From: harlan@dds.mil (Harlan Lieberman-Berg)
Date: Sat, 11 Aug 2018 14:29:41 -0400
Subject: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
In-Reply-To: <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
	<CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
	<20180810165735.GT4692@linux.intel.com>
	<20180810214433.GA15044@linux.intel.com>
	<CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
Message-ID: <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 11, 2018 at 5:42 AM, Tomas Winkler <tomasw@gmail.com> wrote:
> What platform is this? This is not regular 0xfed40000 address space. I
> guess this is BYT or CHT.  It's better to get dmideoce dump as well.

Hello Tomas, Jarkko, all,

I'm not sure what's up with that.  I've updated the firmware to the
latest version (with no fix, sadly), and re-dumped the ACPI tables.
They now process correctly through isl v20180629.  I've also saved the
output of dmidecode for you.

https://gist.github.com/hlieberman-gov/83fa708d41051bafccc553cf0147db4f

Sincerely,
-- 
Harlan Lieberman-Berg
Defense Digital Service
