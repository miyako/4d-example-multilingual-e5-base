## [intfloat/multilingual-e5-base](https://huggingface.co/intfloat/multilingual-e5-base)

|`max_position_embeddings`|`hidden_size`|`num_hidden_layers`
|-:|-:|-:|
|`512`|`768`|`12`

```4d
var $en; $fr : 4D.Vector
var $AIClient : cs.AIKit.OpenAI
var $cosineSimilarity : Real
$AIClient:=cs.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8080/v1"  

$en:=$AIClient.embeddings.create("How do I reset my password?").embedding.embedding
$fr:=$AIClient.embeddings.create("Comment réinitialiser mon mot de passe?").embedding.embedding

$cosineSimilarity:=$en.cosineSimilarity($fr)

ALERT([$cosineSimilarity].join())
```

##### Cosine similarity from example code above:

|llama.cpp `Q8_0`|ONNX Runtime `Int8`|CTranslate2 `Int8`
|-|-|-|
|`0.8737083041335`|`0.8721361305521`|`0.8926017500907`
