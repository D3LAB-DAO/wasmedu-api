const codeRunBtn = document.querySelector('#run-code');
const codeFmtBtn = document.querySelector('#format-code');
const googleLogout = document.querySelector('#google-logout')
const wasmCode = document.querySelector('#wasm-editor');
const editorWarn = document.querySelector('#wasm-editor-error');

codeRunBtn.addEventListener("click", (e) => {
    e.preventDefault();
    console.log(btoa(wasmCode.value));
})

codeFmtBtn.addEventListener("click", async (e) => {
    e.preventDefault();

    const opt = {
        method: 'POST',
        credentials: 'include',
        headers: {
            'Content-Type': 'application/json',
            'Location': "sample location"
        },
        body: JSON.stringify({
            files: {
                file1: btoa(wasmCode.value)
            }
        }),
    }
    try {
        let res = await fetch('http://127.0.0.1:3334/rust/fmt', opt);
        if (res.redirected) {
            window.location.replace(res.url)
        } else {
            res = await res.json();
            wasmCode.value = atob(res.result.file1);
        }



    } catch (err) {
        console.log(err)
        // editorWarn.innerText = atob(res.result);
    }
})
