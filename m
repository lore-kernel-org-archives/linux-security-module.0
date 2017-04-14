From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 14 Apr 2017 19:15:41 +0100
Subject: [PATCH 06/24] Add a sysrq option to exit secure boot mode
In-Reply-To: <alpine.DEB.2.20.1704142003570.2327@nanos>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142332458.5101.14654616837280513947.stgit@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1704142003570.2327@nanos>
Message-ID: <CAKv+Gu-FDzdqACyr_z6Zsgb51mg8Lc0YgfLs4oGURWnX4WewSw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 14 April 2017 at 19:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 5 Apr 2017, David Howells wrote:
>
>> From: Kyle McMartin <kyle@redhat.com>
>>
>> Make sysrq+x exit secure boot mode on x86_64, thereby allowing the running
>> kernel image to be modified.  This lifts the lockdown.
>>
>> Signed-off-by: Kyle McMartin <kyle@redhat.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: x86 at kernel.org
>
> Matt, Ard?
>
> Any opinions on this?
>

>From an EFI point of view, there is not a lot to see here. I think
having a SysRq to lift lockdown makes sense, although I think we
should avoid 'secure boot' when referring to lockdown because they are
really two different things. As someone else pointed out, you may have
other ways of trusting your kernel, in which case you should be able
to lock it down as well.

That does bring me to another EFI related point: many of these patches
are x86 specific for no good reason. We have been working really hard
over the past couple of years to move EFI plumbing into
drivers/firmware/efi, and things are not intimately related to an
architecture should ideally be implemented there. Looking at the
diffstat of this patch, I don't see why this should be a x86 only
feature.

In general, though, I think this should be two patches, one that
introduces the functionality to restrict some SysRq keys to console
only, and one that adds the 'x' for lockdown lift.

I haven't gotten around to responding to David's general email
regarding the point of all of this. I will do so asap, but it will
need to wait until Tuesday at least.

-- 
Ard.


On 14 April 2017 at 19:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 5 Apr 2017, David Howells wrote:
>
>> From: Kyle McMartin <kyle@redhat.com>
>>
>> Make sysrq+x exit secure boot mode on x86_64, thereby allowing the running
>> kernel image to be modified.  This lifts the lockdown.
>>
>> Signed-off-by: Kyle McMartin <kyle@redhat.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: x86 at kernel.org
>
> Matt, Ard?
>
> Any opinions on this?
>
> Thanks,
>
>         tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
