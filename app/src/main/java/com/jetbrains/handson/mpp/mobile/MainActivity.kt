package com.jetbrains.handson.mpp.mobile

import android.content.Intent
import android.net.Uri
import android.net.http.HttpResponseCache.install
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Spinner
import android.widget.TextView

class MainActivity : AppCompatActivity(), ApplicationContract.View {

    lateinit var departureStationSpinner: Spinner
    lateinit var arrivalStationSpinner: Spinner

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val presenter = ApplicationPresenter()
        presenter.onViewTaken(this)

        departureStationSpinner = findViewById<Spinner>(R.id.stations_spinner1) as Spinner
        arrivalStationSpinner = findViewById<Spinner>(R.id.stations_spinner2) as Spinner
        departureStationSpinner.setSelection(0)
        arrivalStationSpinner.setSelection(1)
    }

    override fun setLabel(text: String) {
        //findViewById<TextView>(R.id.main_text).text = text
    }

    fun onSubmitClicked(view: View) {

        var departureCode = departureStationSpinner.selectedItem.toString()
        val ld = departureCode.length
        departureCode = departureCode.substring(ld - 4, ld - 1)

        var arrivalCode = arrivalStationSpinner.selectedItem.toString()
        val ad = arrivalCode.length
        arrivalCode = arrivalCode.substring(ad - 4, ad - 1)
        //val currentTime = LocalDateTime.now()
        //println(currentTime.toString())
        //val apiCall = "https://mobile-api-softwire2.lner.co.uk/v1/fares?originStation=$departureCode&destinationStation=$arrivalCode&outboundDateTime=${currentTime.toString()}"
        val url =
            "https://www.lner.co.uk/travel-information/travelling-now/live-train-times/depart/$departureCode/$arrivalCode/#LiveDepResults"

        val intent = Intent(Intent.ACTION_VIEW)
        intent.data = Uri.parse(url)
        startActivity(intent)
    }
}