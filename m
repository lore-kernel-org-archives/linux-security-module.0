From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 10 Jun 2017 17:01:31 +0800
Subject: [PATCH v2 01/11] crypto: introduce crypto wait for async op
In-Reply-To: <CAOtvUMeRtcVcp8HE9oJAkJO35yF9XBsry3tdNQYj-e31DnDFQQ@mail.gmail.com>
References: <1496046180-21962-1-git-send-email-gilad@benyossef.com>
	<1496046180-21962-2-git-send-email-gilad@benyossef.com>
	<20170610034336.GB14206@gondor.apana.org.au>
	<CAOtvUMeRtcVcp8HE9oJAkJO35yF9XBsry3tdNQYj-e31DnDFQQ@mail.gmail.com>
Message-ID: <20170610090131.GA15594@gondor.apana.org.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Jun 10, 2017 at 11:05:39AM +0300, Gilad Ben-Yossef wrote:
>
> I guess there is a question if it really is important to know that
> your request ended up
> on the backlog, rather than being handled.I can imagine it can be used
> as back pressure
> indication but I wonder if someone is using that.

Oh yes we do want it to return EBUSY if we put it on the backlog
because in that case we want the user to stop sending us new
requests.

It's the other case where we dropped the request and returned
EBUSY where I think we could return something other than EBUSY
and get rid of the ambiguity.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
