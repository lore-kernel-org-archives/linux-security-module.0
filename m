From: ebiggers3@gmail.com (Eric Biggers)
Date: Fri, 15 Sep 2017 19:47:53 -0700
Subject: [PATCH] security: keys: switch big_key encryption to AES in CTR
	mode
In-Reply-To: <20170915223723.20789-1-ard.biesheuvel@linaro.org>
References: <20170915223723.20789-1-ard.biesheuvel@linaro.org>
Message-ID: <20170916024753.GA6901@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Added Jason Donenfeld to Cc]

Hi Ard,

On Fri, Sep 15, 2017 at 03:37:23PM -0700, Ard Biesheuvel wrote:
> The ECB chaining mode only supports inputs that are a multiple of the
> blocksize. Furthermore, it is not recommended for direct use, given
> that it may reveal recurring patterns in the plaintext, due to the
> lack of feedback between input blocks. So let's solve both issues at
> once, and switch to AES in CTR mode.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The choice of ECB here is definitely a mistake, but it really should use an
authenticated encryption mode such as GCM rather than plain CTR.  There was a
patch a few months ago that implemented this and fixed a couple other problems,
but it hasn't been merged; maybe someone wants to take over that patch instead?
Link: http://lkml.kernel.org/r/20170607101209.7603-1-Jason at zx2c4.com

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
