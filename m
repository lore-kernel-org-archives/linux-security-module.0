From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 18 Apr 2017 09:06:40 +0300
Subject: [PATCH 15/24] asus-wmi: Restrict debugfs interface when the
	kernel is locked down
In-Reply-To: <13615.1491830208@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142340198.5101.8171352010918423590.stgit@warthog.procyon.org.uk>
	<CAHp75VfpsnCHVqnFnwwh3JHB0ccY66Gj88sMGhrA9W7rDxiY_Q@mail.gmail.com>
	<31421.1491569449@warthog.procyon.org.uk>
	<CAHp75VfvWmv7SxgwCgR-ZBYPbeQW=+qesDoBNC5JFPtvzsN5gg@mail.gmail.com>
	<13615.1491830208@warthog.procyon.org.uk>
Message-ID: <CAHp75Vd+-_CmW2MPpK3b6bER8bFmECusnx0BZMwYAizWZys4YA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 10, 2017 at 4:16 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> >> It looks a bit fragile when responsility of whatever reasons kernel
>> >> can't serve become a driver burden.
>> >> Can we fix this in debugfs framework instead?
>> >
>> > Fix it with debugfs how?  We can't offload the decision to userspace.
>>
>> I mean to do at least similar like you have done for module
>> parameters. So, instead of putting above code to each attribute in
>> question make a special (marked) attribute instead and debugfs
>> framework will know how to deal with that.
>
> Hmmm...  It's tricky in that debugfs doesn't have any of its own structures,
> but is entirely built on standard VFS ones, so finding somewhere to store the
> information is going to be awkward.

I see.

>  One obvious solution is to entirely lock
> down debugfs in secure boot more, but that might be a bit drastic.

But this sounds sane! debugFS for debugging, not for production. If
someone is using secure kernel it means pure production use (otherwise
one may do temporary hacks in kernel).
If one still needs debugfs in secure mode, it sounds to me as
architectural bug in code in question.

>
> Note that it's still going to be a driver burden to some extent anyway.  The
> driver has to tell the core what needs to be restricted.
>
> Further, I guess configfs needs attention also.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
