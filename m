From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Mon, 21 Aug 2017 15:49:41 +0300
Subject: [PATCH v5 05/19] crypto: introduce crypto wait for async op
In-Reply-To: <20170815032303.000042b2@huawei.com>
References: <1502724094-23305-1-git-send-email-gilad@benyossef.com>
	<1502724094-23305-6-git-send-email-gilad@benyossef.com>
	<20170815032303.000042b2@huawei.com>
Message-ID: <CAOtvUMfJaG-Uomc1EnD1+HySz+X8SUaRUm1SEx4DusquWfOF0w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 15, 2017 at 5:23 AM, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 14 Aug 2017 18:21:15 +0300
> Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>
>> Invoking a possibly async. crypto op and waiting for completion
>> while correctly handling backlog processing is a common task
>> in the crypto API implementation and outside users of it.
>>
>> This patch adds a generic implementation for doing so in
>> preparation for using it across the board instead of hand
>> rolled versions.

>
> Trivial observation.  Shouldn't have this bonus blank line inserted here.
>
>>  #endif       /* _LINUX_CRYPTO_H */
>>
>

Indeed. Will be fixed.

Thanks,
Gilad

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
