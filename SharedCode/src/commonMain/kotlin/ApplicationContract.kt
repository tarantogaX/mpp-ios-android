package com.jetbrains.handson.mpp.mobile

import kotlinx.coroutines.CoroutineScope

interface ApplicationContract {
    interface View {
        fun setLabel(text: String)
        fun updateSearchResults(results: List<String>)
        fun onGetStationsList(stations: List<String>, codes: List<String>)
        fun getOutboundJourneyObjects(outboundJourneys: List<OutboundJourney>)
    }

    abstract class Presenter: CoroutineScope {
        abstract fun onViewTaken(view: View)
        abstract fun getTrainTimes(departureStation: String, arrivalStation: String)
    }
}
