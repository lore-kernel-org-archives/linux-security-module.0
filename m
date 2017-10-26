From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 26 Oct 2017 10:50:27 -0600
Subject: [PATCH v3] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <CANc+2y7hknynCpgmRk2uYH7k5QFdH3hER0jNayNfZUymOEyr6A@mail.gmail.com>
References: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
	<CANc+2y7D+p+wq1tKCydZU0qwWWfUscv3+CQuxPNfzEacEzVDBg@mail.gmail.com>
	<20171026160759.bycrmywqqxtjzpqk@linux.intel.com>
	<CANc+2y7hknynCpgmRk2uYH7k5QFdH3hER0jNayNfZUymOEyr6A@mail.gmail.com>
Message-ID: <20171026165027.GA5829@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 09:57:12PM +0530, PrasannaKumar Muralidharan
wrote:

> I do not what value my rb tag provides as I have not contributed code
> to it before. Is it encouraged by kernel community?

Yes. People will judge the quality of your rb tag based on other
reviews they have seen you make, and here you found a bug, so very
good.

Got to start someplace.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
