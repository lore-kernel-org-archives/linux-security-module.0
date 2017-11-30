From: keescook@chromium.org (Kees Cook)
Date: Wed, 29 Nov 2017 16:06:48 -0800
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <CA+55aFyobrT7SkFC+PVX0USvRicVt_UPH_nkc-G9Bi8yrCCgPw@mail.gmail.com>
References: <20171129134612.72ccb53d@alans-desktop>
	<20171129.095014.1909386937628805919.davem@davemloft.net>
	<20171129155406.i2lyclquj75lvtn4@thunk.org>
	<20171129.105816.1108278026315471171.davem@davemloft.net>
	<CA+55aFyobrT7SkFC+PVX0USvRicVt_UPH_nkc-G9Bi8yrCCgPw@mail.gmail.com>
Message-ID: <CAGXu5jL+qmekLedFxRC5O7jFdtZUh0NcnLSU7x7mC+zNORTCeg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 29, 2017 at 2:45 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Nov 29, 2017 at 7:58 AM, David Miller <davem@davemloft.net> wrote:
>>
>> We're talking about making sure that loading "ppp.ko" really gets
>> ppp.ko rather than some_other_module.ko renamed to ppp.ko via some
>> other mechanism.
>>
>> Both modules have legitimate signatures so the kernel will happily
>> load both.
>
> Yes. We could make the module name be part of the signing process, but
> one problem with that is that at module loading time we don't actually
> have the filename any more.

FWIW, I added this (well, KBUILD_MODNAME) to the module info just recently:

3e2e857f9c3a ("module: Add module name to modinfo")

> User space opens the file and then just feeds the data to the kernel.
> So if you fooled modprobe into feeding the wrong module, that's it.
>
> And yes, we can obviously embed the module name into the ELF headers
> (that is all part of the signed payload), but the module name doesn't
> actually necessarily match what we originally asked for.
>
> Why? Module aliases and module dependencies - which is why we have
> that user mode side at all. When we do "request_module(XYZ)" we don't
> necessarily know what the dependencies are, so we expect modprobe to
> just load the right modules.
>
> So if modprobe then loads some other module (dccp or whatever), the
> kernel has no real way to know "oh, that wasn't part of the dependency
> chain for the module we aked for".
>
> Now, if modprobe is taught to check that the filename of the module
> that it opens actually matches the metadata in the ELF sections, that
> would solve it, but it's out of the kernels hands..

Right, the aliases are why these kinds of renaming shenanigans don't
mean anything: it's not distinguishable from whatever modprobe.conf
ultimately tells modprobe to do.

If you can't trust your filesystem to hold your kernel modules
correctly, you have much bigger problems. (And yes, capabilities are a
problem here, since there are many paths to full root from individual
capabilities, but that's a known issue that is much larger than
tricking modprobe.)

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
