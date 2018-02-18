From: hpa@zytor.com (hpa at zytor.com)
Date: Sat, 17 Feb 2018 16:26:45 -0800
Subject: [PATCH v3 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <1518912912.5667.277.camel@linux.vnet.ibm.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
	<1518813234-5874-2-git-send-email-takondra@cisco.com>
	<d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
	<1518912912.5667.277.camel@linux.vnet.ibm.com>
Message-ID: <117FCFDB-EA4C-4C0C-A01E-7C6C86693E6F@zytor.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On February 17, 2018 4:15:12 PM PST, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>On Fri, 2018-02-16 at 12:59 -0800, H. Peter Anvin wrote:
>> On 02/16/18 12:33, Taras Kondratiuk wrote:
>> > Many of the Linux security/integrity features are dependent on file
>> > metadata, stored as extended attributes (xattrs), for making
>decisions.
>> > These features need to be initialized during initcall and enabled
>as
>> > early as possible for complete security coverage.
>> > 
>> > Initramfs (tmpfs) supports xattrs, but newc CPIO archive format
>does not
>> > support including them into the archive.
>> > 
>> > This patch describes "extended" newc format (newcx) that is based
>on
>> > newc and has following changes:
>> > - extended attributes support
>> > - increased size of filesize to support files >4GB
>> > - increased mtime field size to have 64 bits of seconds and added a
>> >   field for nanoseconds
>> > - removed unused checksum field
>> > 
>> 
>> If you are going to implement a new, non-backwards-compatible format,
>> you shouldn't replicate the mistakes of the current format. 
>Specifically:
>> 
>> 1. The use of ASCII-encoded fixed-length numbers is an idiotic legacy
>> from an era before there were any portable way of dealing with
>numbers
>> with prespecified endianness.  If you are going to use ASCII, make
>them
>> delimited so that they don't have fixed limits, or just use binary.
>> 
>> The cpio header isn't fixed size, so that argument goes away, in fact
>> the only way to determine the end of the header is to scan forward.
>> 
>> 2. Alignment sensitivity!  Because there is no header length
>> information, the above scan tells you where the header ends, but
>there
>> is padding before the data, and the size of that padding is only
>defined
>> by alignment.
>> 
>> 3. Inband encoding of EOF: if you actually have a filename
>"TRAILER!!!"
>> you have problems.
>> 
>> But first, before you define a whole new format for which no tools
>exist
>> (you will have to work with the maintainers of the GNU tools to add
>> support) you should see how complex it would be to support the POSIX
>> tar/pax format, which already has all the features you are seeking,
>and
>> by now is well-supported.
>
>The discussion about including xattrs in the initramfs didn't start
>yesterday. ?It's been on the list of measurement/appraisal gaps that
>need to be closed for years. ?Initially I planned on using tar, but at
>the 2014 Kernel Summit I spoke with Al at length. ?At the time, he was
>very clear that tar is unnecessarily overly complicated and
>recommended extending CPIO.
>
>I took his advice. ?Unfortunately, as soon as I posted an initial
>patch set to include xattrs in CPIO, all of the problems with CPIO had
>to be addressed before defining a new CPIO number. ?Unfortunately,
>this wasn't the only measurement/appraisal gap that needed to be
>addressed. ?I've been working on closing other gaps.
>
>I'm really happy that someone has taken the time to work on this.
>?Instead of derailing their attempt of extending CPIO to include
>xattrs, I'd appreciate your making constructive suggestions.
>
>Mimi

Do you have a description of the gaps you have identified?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
