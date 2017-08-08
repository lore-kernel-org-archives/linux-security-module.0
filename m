From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Tue, 8 Aug 2017 16:45:36 +0300
Subject: [PATCH v4 06/19] crypto: move algif to generic async completion
In-Reply-To: <8585274.Umn6qnzcUd@tauon.chronox.de>
References: <1502193834-11289-1-git-send-email-gilad@benyossef.com>
	<1502193834-11289-7-git-send-email-gilad@benyossef.com>
	<8585274.Umn6qnzcUd@tauon.chronox.de>
Message-ID: <CAOtvUMfp7Hie_RA8XNmWS084PvyO_xB0VAf2Vt9nR68cQhz3=g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 8, 2017 at 4:10 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Dienstag, 8. August 2017, 14:03:37 CEST schrieb Gilad Ben-Yossef:
>
> Hi Gilad,
>
>> algif starts several async crypto ops and waits for their completion.
>> Move it over to generic code doing the same.
>
> Just FYI: your patch set and my patch [1] will clash.
>
> [1] https://patchwork.kernel.org/patch/9875959/

I'll try to rebase on linux-next + your patch than.

Thanks for letting me know.

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
