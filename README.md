## [intfloat/multilingual-e5-base](https://huggingface.co/intfloat/multilingual-e5-base)

E5 is a text embedding model released by Microsoft in 2023. It was explicitly trained to measure the distance between a query and a passage to perform asymmetric tasks.

|`max_position_embeddings`|`hidden_size`|`num_hidden_layers`|`pooling`
|-:|-:|-:|-:|
|`512`|`768`|`12`|`mean`

```4d
var $AIClient : cs.AIKit.OpenAI
$AIClient:=cs.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8080/v1"  // llama-server

$query:="query: 4D Serverが使用するTCPポート番号を教えて?"

var $batch : cs.AIKit.OpenAIEmbeddingsResult
$batch:=$AIClient.embeddings.create($query)

If ($batch.success)
	$vector:=$batch.embedding.embedding
	var $comparison:={vector: $vector; metric: mk cosine; threshold: 0.85}
	var $results:=ds.Documents.query("Embeddings > :1"; $comparison)
	If ($results.length#0)
		ALERT($results.first().Text)
	End if 
End if 
```
