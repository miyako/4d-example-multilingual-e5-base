//%attributes = {}
var $en; $fr : 4D:C1709.Vector
var $AIClient : cs:C1710.AIKit.OpenAI
var $cosineSimilarity : Real
$AIClient:=cs:C1710.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8080/v1"  // llama-server

$fr:=$AIClient.embeddings.create("query: Comment réinitialiser mon mot de passe?").embedding.embedding
$en:=$AIClient.embeddings.create("passage: To reset your password you must contanct customer support.").embedding.embedding

$cosineSimilarity:=$fr.cosineSimilarity($en)
//0.8202557874795

ALERT:C41([$cosineSimilarity].join())