async function apiGet(url){
  const res = await fetch(url, {headers: {"Accept":"application/json"}});
  return res.json();
}