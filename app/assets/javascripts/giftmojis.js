function Giftmoji(name, tag, price, emotions){
	this.name = name
	this.tag = tag 
	this.price = price 
	this.emotions = emotions
}

 Giftmoji.prototype.emotionsPrint = () => {
 	let emoArray = this.emotions 
 	let emoPrint = ""
  for(let i=0;i<emoArray.length;i++){
  emoPrint += emoArray[i]["name"]
  if(i<emoArray.length-1){
  emoPrint += ", "
} else 
{
	emoPrint += ". "
  }

}
    	  
return emoPrint
      }

