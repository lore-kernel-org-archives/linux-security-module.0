From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 15 May 2018 08:43:39 -0400
Subject: [PATCH 3/6] firmware: differentiate between signed
	regulatory.db and other firmware
In-Reply-To: <CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
References: <20180509212212.GX27853@wotan.suse.de>
	<1525903617.3551.281.camel@linux.vnet.ibm.com>
	<20180509234814.GY27853@wotan.suse.de>
	<1525917658.3551.322.camel@linux.vnet.ibm.com>
	<20180510232639.GF27853@wotan.suse.de>
	<1526014826.3414.46.camel@linux.vnet.ibm.com>
	<20180511215250.GJ27853@wotan.suse.de>
	<1526302692.3898.145.camel@linux.vnet.ibm.com>
	<20180514192853.GM27853@wotan.suse.de>
	<1526349751.3937.78.camel@linux.vnet.ibm.com>
	<20180515032656.GR27853@wotan.suse.de>
	<CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
Message-ID: <1526388219.3937.137.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-05-15 at 08:32 -0400, Josh Boyer wrote:

> One aspect that was always a concern to some is whether the firmware files
> were modified directly to have the signature attached to them.  That may
> run afoul of the "no modification" license that most blobs are shipped
> under.  Does IMA have the signatures for the files stored in xattrs or in
> some other detached manner?

They're stored as xattrs. ?RPM has support for including file
signatures in the RPM header.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
