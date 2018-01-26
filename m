From: takondra@cisco.com (Taras Kondratiuk)
Date: Fri, 26 Jan 2018 12:37:14 -0800
Subject: [PATCH v2 11/15] gen_init_cpio: add newcx format
In-Reply-To: <b3451193-0666-d929-01f3-29d3872bd5d4@landley.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-12-git-send-email-takondra@cisco.com>
	<b3451193-0666-d929-01f3-29d3872bd5d4@landley.net>
Message-ID: <151699903485.21956.15795523878472133751@takondra-t460s>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Rob Landley (2018-01-25 18:40:25)
> On 01/24/2018 09:27 PM, Taras Kondratiuk wrote:
> > diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
> > index 7a2a6d85345d..78a47a5bdcb1 100644
> > --- a/usr/gen_init_cpio.c
> > +++ b/usr/gen_init_cpio.c
> > @@ -10,6 +10,7 @@
> >  #include <errno.h>
> >  #include <ctype.h>
> >  #include <limits.h>
> > +#include <assert.h>
> 
> You're adding an assert? Really?
> 
> >       fputs(s, stdout);
> > -     offset += 110;
> > +     assert((offset & 3) == 0);
> > +     offset += cpio_hdr_size;
> 
> Why?

Current code assumes that previous file entry in cpio is padded to 4
byte boundary. The assert just captures this assumption. It should be
true unless there is a bug in the code and some padding is missing.

Actually this assert should be a part of the next patch (#12) that
modifies padding code.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
