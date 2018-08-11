From: tomasw@gmail.com (Tomas Winkler)
Date: Sat, 11 Aug 2018 12:42:53 +0300
Subject: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
In-Reply-To: <20180810214433.GA15044@linux.intel.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
	<CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
	<20180810165735.GT4692@linux.intel.com>
	<20180810214433.GA15044@linux.intel.com>
Message-ID: <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 11, 2018 at 12:45 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Aug 10, 2018 at 07:57:35PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 07, 2018 at 02:43:10PM -0400, Harlan Lieberman-Berg wrote:
> > > (Resending as it seems to have been spamfiltered out from the ml;
> > > sorry Peter, Jarkko for the duplicate)
> >
> > I came on Monday from four week leave and have been basically been
> > catching up with my emails :-) I'll look into this next week with
> > time.
>
> The error message is saying that someone else has reserved the resource
> (-EBUSY).
>
> This looks odd:
>
> e78bf000-e7bbefff : ACPI Non-volatile Storage
>   e7bb6000-e7bb9fff : MSFT0101:00
>   e7bba000-e7bbdfff : MSFT0101:00
>
> Why would be TPM registers mapped inside ACPI NV?
>
> I would *guess* that what is happening is that perhaps drivers/acpi/nvs.c
> maps the address space. This looks like a firmware bug, and such that we
> cannot do anything about it.
>
> I'm having a weird issue with the ACPI tables:
>
> $ acpixtract acpidump.txt
>
> Intel ACPI Component Architecture
> ACPI Binary Table Extraction Utility version 20180105
> Copyright (c) 2000 - 2018 Intel Corporation
>
>   DSDT -   31048 bytes written (0x00007948) - dsdt.dat
>   SSDT -     349 bytes written (0x0000015D) - ssdt1.dat
>   SSDT -   18086 bytes written (0x000046A6) - ssdt2.dat
>   SSDT -    5225 bytes written (0x00001469) - ssdt3.dat
>   SSDT -    1082 bytes written (0x0000043A) - ssdt4.dat
>   SSDT -    1017 bytes written (0x000003F9) - ssdt5.dat
>   SSDT -    5369 bytes written (0x000014F9) - ssdt6.dat
>
> $ iasl -d *.dat
>
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20180105
> Copyright (c) 2000 - 2018 Intel Corporation
>
> Input file dsdt.dat, Length 0x7948 (31048) bytes
> Table [DSDT] is too long for file - needs: 0x815D, remaining in file: 0x7948
> Could not get ACPI tables from dsdt.dat, AE_BAD_HEADER
>
> This has not happened to me before.
What platform is this? This is not regular 0xfed40000 address space. I
guess this is BYT or CHT.  It's better to get dmideoce dump as well.
It looks more like a BIOS issue.
Please forward the complete data.
Thanks
Tomas
