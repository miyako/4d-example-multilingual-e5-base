/*

llama-server settings

*/

var $llama : cs:C1710.llama.llama
var $homeFolder : 4D:C1709.Folder
var $huggingface : cs:C1710.event.huggingface

/*

callbacks for downloader (alert on error)

*/

var $event : cs:C1710.event.event
$event:=cs:C1710.event.event.new()
$event.onError:=Formula:C1597(ALERT:C41($2.message))
//$event.onSuccess:=Formula(ALERT($2.models.extract("name").join(",")+" loaded!"))
$event.onData:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":"+String:C10((This:C1470.range.end/This:C1470.range.length)*100; "###.00%")))
$event.onResponse:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":download complete"))
$event.onTerminate:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; (["process"; $1.pid; "terminated!"].join(" "))))

var $options : Object
var $huggingfaces : cs:C1710.event.huggingfaces
var $folder : 4D:C1709.Folder
var $path : Text
var $URL : Text
var $pooling : Text

/*

model settings (llama.cpp)

use Q8_0 quantisation

*/

$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".GGUF")
$port:=8080
$options:={\
embeddings: True:C214; \
pooling: "mean"; \
log_disable: True:C214; \
fit: "on"}

$folder:=$homeFolder.folder("multilingual-e5-base")
$path:="multilingual-e5-base-Q8_0.gguf"
$URL:="keisuke-miyako/multilingual-e5-base-gguf-q8_0"

$huggingface:=cs:C1710.event.huggingface.new($folder; $URL; $path)
$huggingfaces:=cs:C1710.event.huggingfaces.new([$huggingface])


$llama:=cs:C1710.llama.llama.new($port; $huggingfaces; $homeFolder; $options; $event)

/*

ONNX Runtime: 

use int8 quantisation

*/

$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".ONNX")
$port:=8081
$options:={pooling: "mean"}

$folder:=$homeFolder.folder("multilingual-e5-base")
$path:="multilingual-e5-base-onnx-int8"
$URL:="keisuke-miyako/multilingual-e5-base-onnx-int8"

$huggingface:=cs:C1710.event.huggingface.new($folder; $URL; $path; "embedding"; ($URL="@-f16" || ($URL="@-f32")) ? "model.onnx" : "model_quantized.onnx")
$huggingfaces:=cs:C1710.event.huggingfaces.new([$huggingface])

$ONNX:=cs:C1710.ONNX.ONNX.new($port; $huggingfaces; $homeFolder; $options; $event)


/*

CTranslate2: 

use int8 quantisation

*/

$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".CTranslate2")
$port:=8082
$options:={pooling: "mean"}

$folder:=$homeFolder.folder("multilingual-e5-base")
$path:="multilingual-e5-base-ct2-int8"
$URL:="keisuke-miyako/multilingual-e5-base-ct2-int8"

$huggingface:=cs:C1710.event.huggingface.new($folder; $URL; $path; "embedding")
$huggingfaces:=cs:C1710.event.huggingfaces.new([$huggingface])

$CTranslate2:=cs:C1710.CTranslate2.CTranslate2.new($port; $huggingfaces; $homeFolder; $options; $event)