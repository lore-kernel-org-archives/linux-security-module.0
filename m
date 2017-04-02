From: corbet@lwn.net (Jonathan Corbet)
Date: Sun, 2 Apr 2017 14:34:18 -0600
Subject: [PATCH 0/9] convert genericirq.tmpl and kernel-api.tmpl to DocBook
In-Reply-To: <cover.1490904090.git.mchehab@s-opensource.com>
References: <cover.1490904090.git.mchehab@s-opensource.com>
Message-ID: <20170402143418.3de75239@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 30 Mar 2017 17:11:27 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:

> This series converts just two documents, adding them to the
> core-api.rst book. It addresses the errors/warnings that popup
> after the conversion.
> 
> I had to add two fixes to scripts/kernel-doc, in order to solve
> some of the issues.

I've applied the set, including the add-on to move some stuff to
driver-api - thanks.

For whatever reason, I had a hard time applying a few of these; "git am"
would tell me this:

> Applying: docs-rst: core_api: move driver-specific stuff to drivers_api
> fatal: sha1 information is lacking or useless (Documentation/driver-api/index.rst).
> Patch failed at 0001 docs-rst: core_api: move driver-specific stuff to drivers_api
> The copy of the patch that failed is found in: .git/rebase-apply/patch

I was able to get around this, but it took some hand work.  How are you
generating these?

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
