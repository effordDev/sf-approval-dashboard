import { LightningElement } from 'lwc';
import getProcessInstanceWorkitems from '@salesforce/apex/CustomApprovalDashboardHelper.getProcessInstanceWorkitems'

export default class TotalApprovalsByActor extends LightningElement {
     data = []

     connectedCallback() {
          this.fetchData()
     }
     
     get labels() {
          return this.data.map(item => item.Name)
     }

     get values() { 
          return this.data.map(item => item.value)
     }

     async fetchData() {
          this.data = await getProcessInstanceWorkitems()

          this.backgroundColors = Array.apply(null, Array(this.data.length)).map(item => random_rgba())
          this.backgroundBorderColors = this.backgroundColors?.map(item => item.replace('0.5', '1'))
     }
}

function random_rgba() {
     var o = Math.round, r = Math.random, s = 255;
     return 'rgba(' + o(r()*s) + ', ' + o(r()*s) + ', ' + o(r()*s) + ', ' + 0.5 + ')'
}