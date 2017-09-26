From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 26 Sep 2017 15:10:32 -0400
Subject: about context gap
In-Reply-To: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
References: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
Message-ID: <f3d04c67-5470-e167-d186-755a56edf059@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/16/2017 11:36 AM, Jarkko Sakkinen wrote:
> Hi
> 
> While sitting at the airport I started to think a bit about the context
> gap issue.
> 
> I think first thing that would make sense would be to have a 64-bit
> shadow count for every TPM space i.e.
> 
> atomic_long_t tpm2_ctx_cnt;
> 
> struct tpm2_space {
> 	/* ... */
> 	u64 ctx_cnt;
> };
> 
> For every create and load of a session you will read the global count
> and increase it. This way we have get a well defined order.
> 
> With this organization we could for example put tpm spaces to a
> red-black tree and refresh the oldest tpm space (just first thought
> that came to mind).

I think the algorithm is as follows:

1 - Each saved context has a sequence number.  It can either be 
extracted once and saved in a table or extracted from the context blob 
when needed.

2 - When a startauthsession or contextload returns the 
TPM_RC_CONTEXT_GAP error

2A - find the lowest context blob sequence number
2B - contextload it
2C - contextsave it

This is just for sessions, not objects.

~~

A fundamental design question is whether the application can call 
contextsave for sessions, or whether the command is reserved for the 
resource manager.

I personally think it adds a lot of complication - the session blob has 
to be sort of virtualized.  The use case - one application saving a 
session, then handing it over to another application that loads it - 
doesn't seem worth the complexity.

It should be discussed up front, because it affects the code.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
