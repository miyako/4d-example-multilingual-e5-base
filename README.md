## [intfloat/multilingual-e5-base](https://huggingface.co/intfloat/multilingual-e5-base)

E5 is text embedding model released by Microsoft in 2023. It was explicitly trained to measure the distance between a query and a passage to perform asymmetric tasks.

|`max_position_embeddings`|`hidden_size`|`num_hidden_layers`
|-:|-:|-:|
|`512`|`768`|`12`

```4d
var $en; $fr : 4D.Vector
var $AIClient : cs.AIKit.OpenAI
var $cosineSimilarity : Real
$AIClient:=cs.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8080/v1"  

$fr:=$AIClient.embeddings.create("query: Comment réinitialiser mon mot de passe?").embedding.embedding
$en:=$AIClient.embeddings.create("passage: To reset your password you must contanct customer support.").embedding.embedding

$cosineSimilarity:=$fr.cosineSimilarity($en)

ALERT([$cosineSimilarity].join())
```

##### Cosine similarity from example code above:

|llama.cpp `Q8_0`|ONNX Runtime `Int8`|CTranslate2 `Int8`
|-|-|-|
|`0.81991303476747`|`0.82165533842103`|`0.83689103949804`
