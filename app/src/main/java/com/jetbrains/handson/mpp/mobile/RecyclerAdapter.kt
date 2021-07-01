package com.jetbrains.handson.mpp.mobile

import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.view.menu.ActionMenuItemView
import androidx.recyclerview.widget.RecyclerView

class RecyclerAdapter(private val times: ArrayList<OutboundJourney>): RecyclerView.Adapter<RecyclerView.ViewHolder>() {



    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val inflatedView = parent.inflate(R.layout.recyclerview_item_row, false)
        return ViewHolder(inflatedView)
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        TODO("Not yet implemented")
    }

    override fun getItemCount(): Int {
        return times.size
    }

    inner class ViewHolder(v: View): RecyclerView.ViewHolder(v) {
        var departureTime: TextView
        var arrivalTime: TextView

        init {
            departureTime = itemView.findViewById(R.id.departure_time)
            arrivalTime = itemView.findViewById(R.id.arrival_time)
        }
    }
}