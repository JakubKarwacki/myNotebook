window.onload = Notes;

function Notes()
{
	//Lekcje
	var lessons = new Array;
	lessons[0] = "06-09-2019r";
	lessons[1] = "13-09-2019r";
	lessons[2] = "20-09-2019r";
	lessons[3] = "27-09-2019r";
	lessons[4] = "04-10-2019r";
	lessons[5] = "11-10-2019r";
	lessons[6] = "18-10-2019r";
	lessons[7] = "25-10-2019r";
	lessons[8] = "08-11-2019r";
	lessons[9] = "15-11-2019r";
	lessons[10] = "22-11-2019r";
	lessons[11] = "29-11-2019r";
	lessons[12] = "06-12-2019r";
	lessons[13] = "28-02-2020r";

	//Notatki
	var content = "";
	for(i=1; i<=lessons.length; i++)
	{
		content += '<a href="zeszyt/'+lessons[i-1]+'/'+lessons[i-1]+'.html"><div class="lesson" id="lesson'+i+'"><span class="lessons_numer">Lekcja '+i+'</span><span class="lessons_date">Data: '+lessons[i-1]+'</span></div></a>';
	}
	$('#content_container').html(content);
}
