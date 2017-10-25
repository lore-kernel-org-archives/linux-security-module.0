From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Wed, 25 Oct 2017 20:21:16 +0530
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <20171024182235.d7b3oajc5zcjs57v@linux.intel.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
	<20171024162359.tf5xulhlhokmuxh5@linux.intel.com>
	<CANc+2y4vtr+kbhC_7Rv=rHA2LgEVBHLFEu+DYYK1UmpU63PCgQ@mail.gmail.com>
	<20171024182235.d7b3oajc5zcjs57v@linux.intel.com>
Message-ID: <CANc+2y4BtQGqtC8RJL1Srrz_kWwhyveV3HBpfO1kikFj+0mHaA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Jarkko,

On 24 October 2017 at 23:52, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Tue, Oct 24, 2017 at 10:05:20PM +0530, PrasannaKumar Muralidharan wrote:
>> > 1. Every user in the kernel is using TPM_ANY_NUM, which means there are
>> >    no other users.
>>
>> Completely agree that there is no in kernel users yet.
>
> And should never be. It's a bogus parameter that makes no sense.

I understood that after seeing latest patch that uses struct tpm_chip.
Sorry for the noise.

>> > 2. Moving struct tpm_rng to the TPM client is architecturally
>> >    uacceptable.
>>
>> As there was no response to the patch there is no way to know whether
>> it is acceptable or not.
>
> I like the idea of removing the tpm rng driver as discussed in other
> emails in this thread.

Thank you.

>> > 3. Using zero deos not give you any better guarantees on anything than
>> >    just using TPM_ANY_NUM.
>>
>> Chip id is used, not zero.
>
> Sorry I misread the patch first time. Anyway it's not any kind of ID to
> be trusted.

Okay.

>> > Why this patch is not CC'd to linux-integrity? It modifies the TPM
>> > driver. And in the worst way.
>>
>> TPM list is moderated and the moderator has not approved it yet.
>> get_maintainer script did not say about linux-integrity mailing list.
>>
>> It could be doing things in worst way but it is not known until some
>> one says. If no one tells it is the case I don't think it is possible
>> to fix. Which is what happened.
>
> Understood. We've moved to linux-integrity at vger.kernel.org. MAINTAINERS
> update is in the queue for the next kernel release.

Sorry I never knew this.

>> > Implementing the ideas that Jason explained is the senseful way to
>> > get stable access. modules.dep makes sure that the modules are loaded
>> > in the correct order.
>>
>> If that is sensible then it is the way to go.
>>
>> There must be a reason to believe what is sensible and what is not.
>> Looks like this RFC has helped in judging that.
>>
>> Regards,
>> PrasannaKumar
>
> Would you be interested to work on patch set that would remove the
> existing tpm rng driver and make the TPM driver the customer? It's not
> that far away from the work you've been doing already.
>
> /Jarkko

I am late to the party. Jason has sent a patch doing that by the time
I read this email.

Thanks and regards,
PrasannaKumar
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
