From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Tue, 4 Apr 2017 09:34:25 -0300
Subject: [PATCH 0/9] convert genericirq.tmpl and kernel-api.tmpl to DocBook
In-Reply-To: <20170402143418.3de75239@lwn.net>
References: <cover.1490904090.git.mchehab@s-opensource.com>
	<20170402143418.3de75239@lwn.net>
Message-ID: <20170404093425.54da2050@vento.lan>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Em Sun, 2 Apr 2017 14:34:18 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Thu, 30 Mar 2017 17:11:27 -0300
> Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:
> 
> > This series converts just two documents, adding them to the
> > core-api.rst book. It addresses the errors/warnings that popup
> > after the conversion.
> > 
> > I had to add two fixes to scripts/kernel-doc, in order to solve
> > some of the issues.  
> 
> I've applied the set, including the add-on to move some stuff to
> driver-api - thanks.

Thanks!

> For whatever reason, I had a hard time applying a few of these; "git am"
> would tell me this:
> 
> > Applying: docs-rst: core_api: move driver-specific stuff to drivers_api
> > fatal: sha1 information is lacking or useless (Documentation/driver-api/index.rst).
> > Patch failed at 0001 docs-rst: core_api: move driver-specific stuff to drivers_api
> > The copy of the patch that failed is found in: .git/rebase-apply/patch  
> 
> I was able to get around this, but it took some hand work.  How are you
> generating these?

That's weird. I'm using this to generate the patches:

	git format-patch -o $tmp_dir --stat --summary --patience --signoff --thread=shallow

plus some scripting that runs scripts/get_maintainers.

After that, I run:

	git send-email $tmp_dir

Then, exim sends the patches to a smart SMTP server (currently,
infradead.org, but I'm switching to s-opensource.org, as I'm getting
some troubles because the IP doesn't match the From: line).

Thanks,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
