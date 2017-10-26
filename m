From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Thu, 26 Oct 2017 21:53:30 +0530
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <20171025191123.4uqh6epwhak6hqp5@linux.intel.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
	<20171024162359.tf5xulhlhokmuxh5@linux.intel.com>
	<CANc+2y4vtr+kbhC_7Rv=rHA2LgEVBHLFEu+DYYK1UmpU63PCgQ@mail.gmail.com>
	<20171024182235.d7b3oajc5zcjs57v@linux.intel.com>
	<CANc+2y4BtQGqtC8RJL1Srrz_kWwhyveV3HBpfO1kikFj+0mHaA@mail.gmail.com>
	<20171025191123.4uqh6epwhak6hqp5@linux.intel.com>
Message-ID: <CANc+2y4d-uYninXST5h+hzxmmwXP+VPo662rQB4YG2MB=8JvZA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 26 October 2017 at 00:41, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Wed, Oct 25, 2017 at 08:21:16PM +0530, PrasannaKumar Muralidharan wrote:
>> >> > 2. Moving struct tpm_rng to the TPM client is architecturally
>> >> >    uacceptable.
>> >>
>> >> As there was no response to the patch there is no way to know whether
>> >> it is acceptable or not.
>> >
>> > I like the idea of removing the tpm rng driver as discussed in other
>> > emails in this thread.
>>
>> Thank you.
>
> No, thank you.
>
> I didn't first understand the big idea and only looked at the code
> change per se. I apologize for that.

No need for that. I missed mentioning the reason for the patch and it
is not obvious from code change. Its my fault.

> The problem that you went to solve was real and it led to a properly
> implemented solution. You were not late from the party. Jason's code
> change is derivative work of your code change. That's why his code
> change has also your signed-off-by.
>
> Thanks for doing awesome work :-)

Its really nice to hear such words :-) :-D.

>
> /Jarkko

Thanks and regards,
PrasannaKumar
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
