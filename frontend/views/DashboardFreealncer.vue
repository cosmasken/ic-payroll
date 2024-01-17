<template>
    <div>
        <header>
        <h1 class="text-5xl text-center mt-10">Now! You play with <span class="font-semibold text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">Money</span></h1>
    </header>
    <main class="max-w-screen-xl mx-auto">
        <section class="mt-10">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 m-2">
                <div class="bg-green-500 p-8 text-white rounded-xl">
                    <h4 class="text-2xl">Deposit</h4>
                    <h2 class="text-4xl">$<span id="deposit-total">00</span></h2>
                </div>
                <div class="bg-red-500 p-8 text-white rounded-xl">
                    <h4 class="text-2xl">Withdraw</h4>
                    <h2 class="text-4xl">$<span id="withdraw-total">00</span></h2>
                </div>
                <div class="bg-cyan-500 p-8 text-white rounded-xl">
                    <h4 class="text-2xl">Balance</h4>
                    <h2 class="text-4xl">$<span id="balance-total">1240</span></h2>
                </div>
                
            </div>
        </section>
        <section class="mt-10">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 m-2">
                <div class="bg-indigo-500 p-16  rounded-xl">
                    <h4 class="text-2xl mb-4 text-white">Please Deposit</h4>
                    
                    <input class="mb-2 w-5/6 lg:w-3/4 p-2  " type="text" name="" id="deposit-amount" placeholder="$ Enter Amount">
                    <button id="btn-deposit" class="bg-emerald-500 px-5 py-2 rounded text-white font-semibold hover:bg-gradient-to-l to-emerald-600 from-sky-400">Deposit</button>
                </div>
                <div class="bg-purple-500 p-16  rounded-xl">
                    <h4 class="text-2xl mb-4 text-white">Please Withdraw</h4>
                    
                    <input class="mb-2 w-5/6 lg:w-3/4 p-2  " type="text" name="" id="withdraw-amount" placeholder="$ Enter Amount">
                    <button id="btn-withdraw" class="bg-emerald-500 px-5 py-2 rounded text-white font-semibold hover:bg-gradient-to-l to-emerald-600 from-sky-400">Withdraw</button>
                </div>

            </div>
        </section>
    </main>
    </div>
</template>