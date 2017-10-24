From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Tue, 24 Oct 2017 23:26:52 +0530
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <20171024174637.GB1806@obsidianresearch.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
	<20171024155526.GA32250@obsidianresearch.com>
	<CANc+2y6-P9MvjbL18h02SPwNMPyk4_cPFfL6LKHDXiKSHfv00A@mail.gmail.com>
	<20171024161118.GA348@obsidianresearch.com>
	<CANc+2y4VYWUON2Uo5M7SyyxtrMPiyY1Ln0WEkFLzKsHJ0v_keA@mail.gmail.com>
	<20171024174637.GB1806@obsidianresearch.com>
Message-ID: <CANc+2y523PgF_-ynp2xuor_2RUGLFhnK14F-Wf5i5hwRDmk_Fw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Jason,

On 24 October 2017 at 23:16, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Oct 24, 2017 at 09:44:30PM +0530, PrasannaKumar Muralidharan wrote:
>
>> I am wondering why it is wrong. Isn't the chip id valid till it is
>> unregistered? If so the rfc is correct. Please explain, may be I am
>> missing something.
>
> The lifetime is a bit complicated, but the general rule in the kernel
> for things like this it to use pointers, not ids, and certainly not
> string ids.
>
> For that patch it could just use container_of to get the chip..
>
> Jason

hwrng requires a unique name for every device. In that patch
"tpm-rng-<chip_num>" is used. chip_num is nothing but dev->dev_num.
This way more than 1 tpm chip can be used as rng provider.
tpm_get_random uses chip_num as its parameter. This is why
chip->dev_num was used.

Is that reasoning correct?

Please feel free to correct me if I am wrong.

Thanks,
PrasannaKumar
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
