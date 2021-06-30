package com.jetbrains.handson.mpp.mobile

import io.ktor.client.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import kotlinx.coroutines.*
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import kotlin.coroutines.CoroutineContext

@Serializable
data class OutboundJourney(val departureTime: String, val arrivalTime: String) {
}

@Serializable
data class SerializableResponse(val numberOfAdults: Int, val numberOfChildren: Int, val outboundJourneys: List<OutboundJourney>) {

}

class ApplicationPresenter: ApplicationContract.Presenter() {

    private val dispatchers = AppDispatchersImpl()
    private var view: ApplicationContract.View? = null
    private val job: Job = SupervisorJob()

    val client = HttpClient() {
        install(JsonFeature) {
            serializer = KotlinxSerializer(kotlinx.serialization.json.Json { this.ignoreUnknownKeys = true; this.isLenient = true})
        }
    }

    public fun getTrainTimes(departureStation: String, arrivalStation: String) {
        launch {
            val response: SerializableResponse = client.request("https://mobile-api-softwire2.lner.co.uk/v1/fares?originStation=$departureStation&destinationStation=$arrivalStation&noChanges=false&numberOfAdults=2&numberOfChildren=0&journeyType=single&outboundDateTime=2021-07-24T14%3A30%3A00.000%2B01%3A00&outboundIsArriveBy=false")
        /*val response: SerializableResponse = client.request("https://mobile-api-softwire2.lner.co.uk/v1/fares/") {
                method = HttpMethod.Get
                parameter("originStation", departureStation)
                parameter("destinationStation", arrivalStation)
                parameter("noChanges", "false")
                parameter("numberOfAdults", "1")
                parameter("numberOfChildren", "0")
                parameter("journeyType", "single")
                parameter("outboundDateTime", "2021-07-24T14%3A30%3A00.000%2B01%3A00")
                parameter("outboundIsArriveBy", "false")
            }*/
            println(response.outboundJourneys)
        }

//        val response: HttpResponse = client.request(
//            "https://mobile-api-softwire2.lner.co.uk/v1/fares?origi" +
//                    "nStation=LDS&destinationStation=KGX&noChanges=fal" +
//                    "se&numberOfAdults=2&numberOfChildren=0&journeyType=s" +
//                    "ingle&outboundDateTime=2021-07-24T14%3A30%3A00.000%2B01" +
//                    "%3A00&outboundIsArriveBy=false")
    }

    override val coroutineContext: CoroutineContext
        get() = dispatchers.main + job

    override fun onViewTaken(view: ApplicationContract.View) {
        this.view = view
        view.setLabel(createApplicationScreenMessage())
    }
}
