import { LightningElement } from 'lwc';
import getProcessInstanceWorkitemsWithSobjects from '@salesforce/apex/CustomApprovalDashboardHelper.getProcessInstanceWorkitemsWithSobjects'


export default class TotalApprovalsByActorByObject extends LightningElement {
     response = {}

     connectedCallback() {
          this.fetchData()
     }
     
     get labels() {
          return this.response?.userNames ||[]
     }

     get data() { 
          return this.response?.data || []
     }

     async fetchData() {
          this.response = await getProcessInstanceWorkitemsWithSobjects()
          console.log(JSON.parse(JSON.stringify(this.response)))

          this.response.data.forEach(item => {
               item.backgroundcolor = random_rgba()
          })

          console.log(JSON.parse(JSON.stringify(this.response)))
          // this.backgroundColors = Array.apply(null, Array(this.data.length)).map(item => random_rgba())
          // this.backgroundBorderColors = this.backgroundColors?.map(item => item.replace('0.5', '1'))
     }
}

function random_rgba() {
     var o = Math.round, r = Math.random, s = 255;
     return 'rgba(' + o(r()*s) + ', ' + o(r()*s) + ', ' + o(r()*s) + ', ' + 1 + ')'
}