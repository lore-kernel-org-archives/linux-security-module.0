From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Sun, 12 Nov 2017 10:53:35 +0530
Subject: [PATCH v3] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <20171031200303.GB18578@ziepe.ca>
References: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
	<20171031200303.GB18578@ziepe.ca>
Message-ID: <CANc+2y4si3YW5FXWEdKz0UM5c76MBmHWu4RBF7d2dew9i-Ut+Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Did basic check on tpm rng patch, it works fine. As it depends on this
patch this should be working fine too.

Tested-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
