From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 9 Apr 2017 14:10:10 +0300
Subject: [PATCH 15/24] asus-wmi: Restrict debugfs interface when the
	kernel is locked down
In-Reply-To: <31421.1491569449@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142340198.5101.8171352010918423590.stgit@warthog.procyon.org.uk>
	<CAHp75VfpsnCHVqnFnwwh3JHB0ccY66Gj88sMGhrA9W7rDxiY_Q@mail.gmail.com>
	<31421.1491569449@warthog.procyon.org.uk>
Message-ID: <CAHp75VfvWmv7SxgwCgR-ZBYPbeQW=+qesDoBNC5JFPtvzsN5gg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 7, 2017 at 3:50 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> > From: Matthew Garrett <matthew.garrett@nebula.com>
>> >
>> > We have no way of validating what all of the Asus WMI methods do on a given
>> > machine - and there's a risk that some will allow hardware state to be
>> > manipulated in such a way that arbitrary code can be executed in the
>> > kernel, circumventing module loading restrictions.  Prevent that if the
>> > kernel is locked down.
>>
>> > +       if (kernel_is_locked_down())
>> > +               return -EPERM;
>>
>> It looks a bit fragile when responsility of whatever reasons kernel
>> can't serve become a driver burden.
>> Can we fix this in debugfs framework instead?
>
> Fix it with debugfs how?  We can't offload the decision to userspace.

I mean to do at least similar like you have done for module
parameters. So, instead of putting above code to each attribute in
question make a special (marked) attribute instead and debugfs
framework will know how to deal with that.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
