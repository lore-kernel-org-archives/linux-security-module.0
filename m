From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sun, 16 Sep 2018 15:03:49 +0300
Subject: [PATCH v6 0/2] tpm: add support for nonblocking operation
In-Reply-To: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180916120349.GB5040@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 10, 2018 at 10:18:22AM -0700, Tadeusz Struk wrote:
> The TCG SAPI specification [1] defines a set of functions, which allow
> applications to use the TPM device in either blocking or non-blocking fashion.
> Each command defined by the specification has a corresponding
> Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
> together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> mode of operation. Currently the TPM driver supports only blocking calls,
> which doesn't allow asynchronous IO operations.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this feature.
> The new functionality can be tested using standard TPM tools implemented
> in [2], together with modified TCTI from [3], and an example application
> by Philip Tricca [4]. Here is a short description from Philip:
> 
> "The example application `glib-tss2-event` uses a glib main event loop
> to create an RSA 2048 primary key in the TPM2 NULL hierarchy while
> using a glib timer event to time the operation. A GSource object is
> used to generate an event when the FD underlying the tss2 function
> call has data ready. While the application waits for an event indicating
> that the CreatePrimary operation is complete, it counts timer events
> that occur every 100ms. Once the CreatePrimary operation completes the
> number of timer events that occurred is used to make a rough calculation
> of the elapsed time. This value is then printed to the console.
> This takes ~300 lines of C code and requires no management or
> synchronization of threads. The glib GMainContext is "just a poll()
> loop" according to the glib documentation here:
> 
> https://developer.gnome.org/programming-guidelines/stable/main-contexts.html.en
> 
> and so supporting 'poll' is the easiest way to integrate with glib /
> gtk+. This is true of any other event system that relies on 'poll'
> instead of worker threads."
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
> [2] https://github.com/tpm2-software/tpm2-tools
> [3] https://github.com/tstruk/tpm2-tss/tree/async
> [4] https://github.com/flihp/glib-tss2-async-example

I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async

/Jarkko
