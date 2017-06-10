From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sat, 10 Jun 2017 11:05:39 +0300
Subject: [PATCH v2 01/11] crypto: introduce crypto wait for async op
In-Reply-To: <20170610034336.GB14206@gondor.apana.org.au>
References: <1496046180-21962-1-git-send-email-gilad@benyossef.com>
	<1496046180-21962-2-git-send-email-gilad@benyossef.com>
	<20170610034336.GB14206@gondor.apana.org.au>
Message-ID: <CAOtvUMeRtcVcp8HE9oJAkJO35yF9XBsry3tdNQYj-e31DnDFQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Jun 10, 2017 at 6:43 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, May 29, 2017 at 11:22:48AM +0300, Gilad Ben-Yossef wrote:
>>
>> +static inline int crypto_wait_req(int err, struct crypto_wait *wait)
>> +{
>> +     switch (err) {
>> +     case -EINPROGRESS:
>> +     case -EBUSY:
>> +             wait_for_completion(&wait->completion);
>> +             reinit_completion(&wait->completion);
>> +             err = wait->err;
>> +             break;
>> +     };
>> +
>> +     return err;
>> +}
>
> This assumes that the request is used with backlog.  For non-backlog
> requests this would result in a memory leak as EBUSY in that case is
> a fatal error.
>
> So this API can't be used without backlog.

You are right, of course. I did not take that into account.

>
> We could introduce a flag to indicate whether we want backlog or not,
> or maybe we should change our API so that in the non-backlog case we
> return something other than EBUSY.
>
> Opinions?

I guess there is a question if it really is important to know that
your request ended up
on the backlog, rather than being handled.I can imagine it can be used
as back pressure
indication but I wonder if someone is using that.

If not, maybe we can simplify things and use EINPROGRESS asindication
of a request
being accepted by the next layer (either being processed or queued in
the back log), whereas
EBUSY would indicate failure.

It does have a potential to make things simpler, I think.

Gilad

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt



-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
