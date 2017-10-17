From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 17 Oct 2017 21:09:10 +0800
Subject: [PATCH v9 00/20] simplify crypto wait for async op
In-Reply-To: <CAOtvUMeESbKKaEvpW_MKrRaCxwQWnBa00m4v4F1jNZ_+Xq7pWA@mail.gmail.com>
References: <1508059209-25529-1-git-send-email-gilad@benyossef.com>
	<20171015153831.GA22867@gondor.apana.org.au>
	<CAOtvUMeESbKKaEvpW_MKrRaCxwQWnBa00m4v4F1jNZ_+Xq7pWA@mail.gmail.com>
Message-ID: <20171017130910.GA28534@gondor.apana.org.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 17, 2017 at 02:55:21PM +0300, Gilad Ben-Yossef wrote:
>
> Would you mind if we used ENOSPC instead of E2BIG?
> 
> "No space left on device" seems more appropriate than
> "Argument list too long".

It's fine by me.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
