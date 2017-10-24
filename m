From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 24 Oct 2017 11:46:37 -0600
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <CANc+2y4VYWUON2Uo5M7SyyxtrMPiyY1Ln0WEkFLzKsHJ0v_keA@mail.gmail.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
	<20171024155526.GA32250@obsidianresearch.com>
	<CANc+2y6-P9MvjbL18h02SPwNMPyk4_cPFfL6LKHDXiKSHfv00A@mail.gmail.com>
	<20171024161118.GA348@obsidianresearch.com>
	<CANc+2y4VYWUON2Uo5M7SyyxtrMPiyY1Ln0WEkFLzKsHJ0v_keA@mail.gmail.com>
Message-ID: <20171024174637.GB1806@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 24, 2017 at 09:44:30PM +0530, PrasannaKumar Muralidharan wrote:

> I am wondering why it is wrong. Isn't the chip id valid till it is
> unregistered? If so the rfc is correct. Please explain, may be I am
> missing something.

The lifetime is a bit complicated, but the general rule in the kernel
for things like this it to use pointers, not ids, and certainly not
string ids.

For that patch it could just use container_of to get the chip..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
