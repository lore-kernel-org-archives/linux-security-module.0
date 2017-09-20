From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Wed, 20 Sep 2017 16:01:21 +0200
Subject: [PATCH v6] security/keys: rewrite all of big_key crypto
In-Reply-To: <2545404.XUVGGHhd0i@tauon.chronox.de>
References: <CAHmME9rjrz2Pn39ay3myApBeBtQAPNt0C+NvmFoV28NeT4_zLg@mail.gmail.com>
	<1593673.B5xods8kYN@tauon.chronox.de>
	<CAHmME9pvZ-Q8qoUGjQjXX_DYNVv43C7MJRDzKZAAotM5UZircA@mail.gmail.com>
	<2545404.XUVGGHhd0i@tauon.chronox.de>
Message-ID: <CAHmME9pLF7cdm3RuOa-k8knsikNwU-5BVsnoHNEYw-xpuhW0tg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 20, 2017 at 3:45 PM, Stephan Mueller <smueller@chronox.de> wrote:
> http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/Joux_comments.pdf

Section 3 shows an attack with repeated nonces, which we don't do here.

Section 4 shows an attack using a non-96-bit nonce, which we also don't do here.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
