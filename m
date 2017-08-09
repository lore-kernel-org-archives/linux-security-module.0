From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Wed, 9 Aug 2017 08:18:03 +0300
Subject: [PATCH v4 02/19] crypto: ccm: use -EAGAIN for transient busy
	indication
In-Reply-To: <4600c898-a2f2-f95f-15b4-0adcc6acc0b5@amd.com>
References: <1502193834-11289-1-git-send-email-gilad@benyossef.com>
	<1502193834-11289-3-git-send-email-gilad@benyossef.com>
	<4600c898-a2f2-f95f-15b4-0adcc6acc0b5@amd.com>
Message-ID: <CAOtvUMeUHk9KxQumhuvJ52dp-_-LFOD8XGvCWvhU6LjEZhEF7A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 8, 2017 at 6:24 PM, Gary R Hook <gary.hook@amd.com> wrote:
> On 08/08/2017 07:03 AM, Gilad Ben-Yossef wrote:
>>
>> Replace -EBUSY with -EAGAIN when reporting transient busy
>> indication in the absence of backlog.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
>
> Could we use "ccp" in the subject line, please?

Of course, sorry about the the typo.

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
