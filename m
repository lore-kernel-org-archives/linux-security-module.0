Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFEE301460;
	Tue, 14 Jul 2026 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991649; cv=none; b=jQm/nSRXNJmsn/cKmpMnYRO4f3E9/a5WSSpt5uYjmGsphdWCoH0HPsGaoJng91vfnPT3CJT0ul5X85FwvzDk7kBe051yAuFHC/ZiYkNF7dAv+GOAgALw6X7ocfcYpy6eVYrRERxxdMQNWxEo5/HxisGnvMu8tlgg0A/hIz7W4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991649; c=relaxed/simple;
	bh=pv1QswF79kc10afLBOm6BWVlyCvkZoRui43Tj7foOWk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NU6c6OLHL3GRAcdCVZIrZ7FLm0WCnqp7ZggJxdRyLv7lfQY+NiRhup4WXnNjrVAjEOrHqGp6Kd7DQWuF1+HbVBqvxu5HWHV6P1xHNkgCk7iSBKdSiTtI3J/XL6a82hGficJy6ut5EBE1PTK3oyfkv/KAle83EmRPs00jBWEThNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=mjJsbxRZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nc3T8+en; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="mjJsbxRZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nc3T8+en"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0D7D7A00F7;
	Mon, 13 Jul 2026 21:14:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jul 2026 21:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783991645;
	 x=1784078045; bh=S2pqMWowWzQ6MNdiH9Q6Z+rqNFVuPd2h08eAPsWdfRQ=; b=
	mjJsbxRZUT/bhthYTq0hpMPGg5zy5Wehaf3IuTNbHdOZ4C9Ea/QP+yZyRmqTcRvi
	jmdWtFOgfsps5bZGpkQ3OYmgLPdswsLq1/ol5rwkoL0KQuaqJYCHJksGYtIU0z/9
	WaleLr8Y90H/kEZ2EtngOTf/LtYErP0sIxZpN0d3/y/XUmFYROTWKX7pNgPcaYLf
	D7oAIoTc9GmAr4/y20sx+9MFSE2WMUAC1/BFEVgeEw8/ExvIW/4pMvsoj9qJ9V7/
	AsOR5liiCLJqhEutVdUrVLo/lz4eJGfHm1xkC3lMzSGgqjRAiuvlPm+kGXaXNDCA
	FgJKYC5ggyRZtIcUTwSZtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783991645; x=
	1784078045; bh=S2pqMWowWzQ6MNdiH9Q6Z+rqNFVuPd2h08eAPsWdfRQ=; b=n
	c3T8+endDFmXilfhQp1U87fVwCrc4hz41TJo7ux+ivdvSsbNlVKITA/gsDq/9m1j
	emjDEb+jK+AjEFOKBRoYdE9VHWLFGLt9Wd2d4p+2IOoWFuanSe5le6GVLrOLcZl7
	5NrOhFXv9KpsKo4IhkTKiRdMcuOzQC1mr4Zqw1MSPp7Wr+ElPfq2EGhrj6AMhT6R
	PaCitoJL9z9a1S8UivqmBtEaDSyCYnmkGnObkX10W5nwM4JsHGehul0dLfOh0xnt
	scCWKq4Dxk0smi8OTCauMLW433uf23GSNPlC48o7nSmOcsupFn0OsUunQB1/OS7c
	xvPch+wP2oWF/MoYgeL8g==
X-ME-Sender: <xms:XI1VahqugtXpTLLUNqwKwj4BcMUOt1EmIvpIVsNEZy4IeQ54u2NWWg>
    <xme:XI1Vavk7TKb2pseAb45darl3paznpJdxtrNfzS3hbBgDD60Hf8ceQU_svpu1dhomA
    uWFRTh559UPxQ457ztV-NmcFulDMKHVIXHy9jmVwA2lGFBcRqHljO8>
X-ME-Received: <xmr:XI1VakXbxEZ027MwGSMT-GlqLZjC5BnshtXpCiVYJLL--ScZcEyfxXtY_pm0n842VD02AaqUaYm7cMiTBg>
X-ME-Proxy-Cause: dmFkZTErpNzkTprmTtvfc1brby2UL4Ca5IYSgXLJJtiYywn9eVrD46+FCuJSpWF7olJYWE
    dUM2pWzBinoGYmIxStumDdvv3xljktI19lgDFn4WkDQsNzzxmNMW00y9ekouyJ0hCo4w3s
    MQ9NBHGn4D+V9NVH4exwqFxhQ0AB0s5t8z48kW5NEf0QVnYgBNcU3q4nFCp/npQVmIhYuT
    AXz/a2NY26QfpTsqLePgVnG7rz1Io/4Sa9ZCf5e0g740fD7AzEXU8uV7OcMISh3YCHDTOL
    n1X8dto4eps2FxMINRJsUlQooxBmS20Rn7hJZ8mQGOhtSIzquGhYvqynq3Xfr1LKoXAscj
    kk6jKm7MuJvx/w8cOVqvpygABZLeYzoqhxkIofsDknbk5IK3qboaEiwba1BBBJMj31aut9
    gyqvBAq8oWe4yHtKsEPb2kwmcpDzLuPB5/BKXLNRMRfuCqbyxaTXvzQSXgn0Y8Kq/tdm/R
    61RYOqdm1X84kty0lM3AK1e8DY25NXao6TnggNPzUSZLtLy1u9o5RfJVTrg1Pe/n3gXC/a
    byOLE+VyD0LB51wGZ774Pt57QyHUnsnJY8TpslO9kAL+A9wTZ5cSOmRga1EckU/ZsgozAx
    lEy1Z6oAoTtAUAiRuD//QBSB4JAiBtigvziAx5+NOL0R9b26JJhlD8W8bTHw
X-ME-Proxy: <xmx:XI1VajQzExtFqG_LYhibTu4camZmMRZt8SDv9T9yqvYPBuFjYFOE3A>
    <xmx:XI1VavA33R8t76Jz8hGbN4b3eacowGclXUhAfUL4vy9FIcinFt4bdg>
    <xmx:XI1VauQM25-eyuwv9KB4P4Rovxqrnz5wl684tk6JqCt32VUrhese1g>
    <xmx:XI1VapR0qMKRi2Vl_ZaYTDPoUOOdwYzka5e4yh80RJwWbjTvGetYCA>
    <xmx:XY1Vanliwn2FQ4oovpuvx9PlJX2RI1VWLVaVQdEUKlSJxziokAx8G8Sj>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 21:14:01 -0400 (EDT)
Message-ID: <15ccd30e-e5f2-4612-b0ac-e495748732e6@maowtm.org>
Date: Tue, 14 Jul 2026 02:14:00 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: qemu-devel@nongnu.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>
References: <aMih5XYYrpP559de@codewreck.org>
 <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org> <3061192.c3ltI2prpg@silver>
 <20251013112424.6b93659c@bahia>
Content-Language: en-US
In-Reply-To: <20251013112424.6b93659c@bahia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christian, Greg, Dominique,

Trying to revive this discussion, some answers to Greg's questions below,
then more thoughts on this series and alternatives.

On 10/13/25 10:24, Greg Kurz wrote:
> On Mon, 29 Sep 2025 15:06:59 +0200
> Christian Schoenebeck <linux_oss@crudebyte.com> wrote:
> 
>> On Sunday, September 21, 2025 6:24:49 PM CEST Tingmao Wang wrote:
>>> On 9/17/25 16:00, Mickaël Salaün wrote:
>> [...]
>>
>> Hi Greg,
>>
> 
> Hi Christian,
> 
>> I'd appreciate comments from your side as well, as you are much on longer on
>> the QEMU 9p front than me.
>>
>> I know you won't have the time to read up on the entire thread so I try to
>> summarize: basically this is yet another user-after-unlink issue, this time on
>> directories instead of files.
>>
> 
> Thread that never landed in my mailbox actually and it is quite
> hard to understand the root problem with the content of this
> e-mail actually ;-)
> 
>>> So I did some quick debugging and realized that I had a wrong
>>> understanding of how fids relates to opened files on the host, under QEMU.
>>> It turns out that in QEMU's 9p server implementation, a fid does not
>>> actually correspond to any opened file descriptors - it merely represents
>>> a (string-based) path that QEMU stores internally.  It only opens the
>>> actual file if the client actually does an T(l)open, which is in fact
>>> separate from acquiring the fid with T(l)walk.  The reason why renaming
>>> file/dirs from the client doesn't break those fids is because QEMU will
>>> actually fix those paths when a rename request is processed - c.f.
>>> v9fs_fix_fid_paths [1].
>>
>> Correct, that's based on what the 9p protocols define: a FID does not exactly
>> translate to what a file handle is on a local system. Even after acquiring a
>> new FID by sending a Twalk request, subsequently client would still need to
>> send a Topen for server to actually open that file/directory.
>>
>> And yes, QEMU's 9p server "fixes" the path string of a FID if it was moved
>> upon client request. If the move happened on host side, outside of server's
>> knowledge, then this won't happen ATM and hence it would break your use
>> case.
>>
>>> It turns out that even if a guest process opens the file with O_PATH, that
>>> file descriptor does not cause an actual Topen, and therefore QEMU does
>>> not open the file on the host, and later on reopening that fd with another
>>> mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the file
>>> has moved on the host without QEMU's knowledge.  Also, openat will fail if
>>> provided with a dir fd that "points" to a moved directory, regardless of
>>> whether the fd is opened with O_PATH or not, since path walk in QEMU is
>>> completely string-based and does not actually issue openat on the host fs
>>> [2].
>>
>> I don't think the problem here is the string based walk per se, but rather
>> that the string based walk always starts from the export root:
>>
>> https://github.com/qemu/qemu/blob/4975b64efb5aa4248cbc3760312bbe08d6e71638/hw/9pfs/9p-local.c#L64
>>
>> I guess that's something that could be changed in QEMU such that the walk
>> starts from FID's fs point, as the code already uses openat() to walk relative
>> to a file descriptor (for security reasons actually), Greg?
>>
> 
> Yes this was introduced for security reasons. In a nutshell, the idea is
> to *not* follow symlinks in any element of the path being opened. It thus
> naturally starts at the export root for which we have an fd.
> 
>> That alone would still not fix your use case though: things being moved on
>> host side. For this to work, it would require to already have a fd open on
>> host for the FID. This could be done by server for each FID as you suggested,
>> or it could be done by client by opening the FID.
>>
> 
> Can you elaborate on the "things being move on host side" ? With
> an example of code that breaks on the client side ?

There are two cases where things break: openat() with a previously opened
dir fd, and re-open()ing an O_PATH fd as readable or writable with
/proc/self/fd.

For the first case,
https://fileshare.maowtm.org/9pfs-landlock-fix/20250921/openat.c
is an example program that demonstrates that in QEMU, path walk always
starts from the export root.  The breakage is when the dir is moved on the
host, even if the file still exists within the dir with the same name, the
openat() with the opened dir fd (which translates to a fid in v9fs)
breaks:

    (Host tmpfs exported as 9p to guest /tmp/9p)
    root@7-2-0-rc2-dev:/# ./openat /tmp/9p/dir file
    [   12.264880][  T183] 9pnet: (00000183) >>> TWALK fids 1,2 nwname 1d wname[0] dir
    [   12.265156][  T183] 9pnet: (00000183) >>> size=22 type: 110 tag: 0
    [   12.265466][  T183] 9pnet: (00000183) <<< size=22 type: 111 tag: 0
    [   12.265590][  T183] 9pnet: (00000183) <<< RWALK nwqid 1:
    [   12.265675][  T183] 9pnet: (00000183) <<<     [0] 80.6d10.6a53fe73
    [   12.265781][  T183] 9pnet: (00000183) >>> TGETATTR fid 2, request_mask 6143
    [   12.265903][  T183] 9pnet: (00000183) >>> size=19 type: 24 tag: 0
    [   12.266062][  T183] 9pnet: (00000183) <<< size=160 type: 25 tag: 0
    [   12.266148][  T183] 9pnet: (00000183) <<< RGETATTR st_result_mask=6143
    [   12.266148][  T183] <<< qid=80.6d10.6a53fe73
    [   12.266148][  T183] <<< st_mode=000041e8 st_nlink=2
    [   12.266148][  T183] <<< st_uid=1000 st_gid=1000
    [   12.266148][  T183] <<< st_rdev=0 st_size=3c st_blksize=131072 st_blocks=0
    [   12.266148][  T183] <<< st_atime_sec=1783874216 st_atime_nsec=302475718
    [   12.266148][  T183] <<< st_mtime_sec=1783874163 st_mtime_nsec=254338030
    [   12.266148][  T183] <<< st_ctime_sec=1783874163 st_ctime_nsec=254338030
    [   12.266148][  T183] <<< st_btime_sec=0 st_btime_nsec=0
    [   12.266148][  T183] <<< st_gen=0 st_data_version=0
    [   12.266932][  T183] 9pnet: (00000183) >>> TWALK fids 2,3 nwname 0d wname[0] (null)
    [   12.267038][  T183] 9pnet: (00000183) >>> size=17 type: 110 tag: 0
    [   12.267189][  T183] 9pnet: (00000183) <<< size=9 type: 111 tag: 0
    [   12.267300][  T183] 9pnet: (00000183) <<< RWALK nwqid 0:
    [   12.267368][  T183] 9pnet: (00000183) >>> TLOPEN fid 3 mode 98304
    [   12.267530][  T183] 9pnet: (00000183) >>> size=15 type: 12 tag: 0
    [   12.267779][  T183] 9pnet: (00000183) <<< size=24 type: 13 tag: 0
    [   12.267867][  T183] 9pnet: (00000183) <<< RLOPEN qid 80.6d10.6a53fe73 iounit 0
    Opened /tmp/9p/dir with fd 3
    [   12.268713][  T183] 9pnet: (00000183) >>> TWALK fids 2,4 nwname 1d wname[0] file
    [   12.268816][  T183] 9pnet: (00000183) >>> size=23 type: 110 tag: 0
    [   12.268961][  T183] 9pnet: (00000183) <<< size=22 type: 111 tag: 0
    [   12.269051][  T183] 9pnet: (00000183) <<< RWALK nwqid 1:
    [   12.269116][  T183] 9pnet: (00000183) <<<     [0] 0.6d11.6a53c273
    [   12.269198][  T183] 9pnet: (00000183) >>> TGETATTR fid 4, request_mask 6143
    [   12.269305][  T183] 9pnet: (00000183) >>> size=19 type: 24 tag: 0
    [   12.269454][  T183] 9pnet: (00000183) <<< size=160 type: 25 tag: 0
    [   12.269538][  T183] 9pnet: (00000183) <<< RGETATTR st_result_mask=6143
    [   12.269538][  T183] <<< qid=0.6d11.6a53c273
    [   12.269538][  T183] <<< st_mode=000081a0 st_nlink=1
    [   12.269538][  T183] <<< st_uid=1000 st_gid=1000
    [   12.269538][  T183] <<< st_rdev=0 st_size=0 st_blksize=131072 st_blocks=0
    [   12.269538][  T183] <<< st_atime_sec=1783874265 st_atime_nsec=602603686
    [   12.269538][  T183] <<< st_mtime_sec=1783874163 st_mtime_nsec=254338030
    [   12.269538][  T183] <<< st_ctime_sec=1783874163 st_ctime_nsec=254338030
    [   12.269538][  T183] <<< st_btime_sec=0 st_btime_nsec=0
    [   12.269538][  T183] <<< st_gen=0 st_data_version=0
    [   12.270149][  T183] 9pnet: (00000183) >>> TWALK fids 4,5 nwname 0d wname[0] (null)
    [   12.270249][  T183] 9pnet: (00000183) >>> size=17 type: 110 tag: 0
    [   12.270406][  T183] 9pnet: (00000183) <<< size=9 type: 111 tag: 0
    [   12.270497][  T183] 9pnet: (00000183) <<< RWALK nwqid 0:
    [   12.270561][  T183] 9pnet: (00000183) >>> TLOPEN fid 5 mode 32768
    [   12.270696][  T183] 9pnet: (00000183) >>> size=15 type: 12 tag: 0
    [   12.270879][  T183] 9pnet: (00000183) <<< size=24 type: 13 tag: 0
    [   12.270962][  T183] 9pnet: (00000183) <<< RLOPEN qid 0.6d11.6a53c273 iounit 20000
    Opened file with fd 4
    [   12.271278][  T183] 9pnet: (00000183) >>> TREAD fid 5 offset 0 255
    [   12.271393][  T183] 9pnet: (00000183) >>> size=23 type: 116 tag: 0
    [   12.271577][  T183] 9pnet: (00000183) <<< size=11 type: 117 tag: 0
    [   12.271667][  T183] 9pnet: (00000183) <<< RREAD count 0
    Read 0 bytes:

    [   12.271843][  T183] 9pnet: (00000183) >>> TCLUNK fid 5 (try 0)
    [   12.271978][  T183] 9pnet: (00000183) >>> size=11 type: 120 tag: 0
    [   12.272128][  T183] 9pnet: (00000183) <<< size=7 type: 121 tag: 0
    [   12.272212][  T183] 9pnet: (00000183) <<< RCLUNK fid 5
    [   12.272309][  T183] 9pnet: (00000183) >>> TCLUNK fid 4 (try 0)
    [   12.272407][  T183] 9pnet: (00000183) >>> size=11 type: 120 tag: 0
    [   12.272535][  T183] 9pnet: (00000183) <<< size=7 type: 121 tag: 0
    [   12.272618][  T183] 9pnet: (00000183) <<< RCLUNK fid 4
    Press Enter to openat again or Ctrl-C to exit

    (at this point dir is moved to dir1 on the host, then Enter is pressed here)

    [   32.441881][  T183] 9pnet: (00000183) >>> TWALK fids 2,4 nwname 1d wname[0] file
    [   32.442038][  T183] 9pnet: (00000183) >>> size=23 type: 110 tag: 0
    [   32.442330][  T183] 9pnet: (00000183) <<< size=11 type: 7 tag: 0
    [   32.442438][  T183] 9pnet: (00000183) <<< RLERROR (-2)
    openat: No such file or directory
    [   32.443619][  T183] 9pnet: (00000183) >>> TCLUNK fid 3 (try 0)
    [   32.443790][  T183] 9pnet: (00000183) >>> size=11 type: 120 tag: 0
    [   32.443942][  T183] 9pnet: (00000183) <<< size=7 type: 121 tag: 0
    [   32.444037][  T183] 9pnet: (00000183) <<< RCLUNK fid 3
    [   32.444127][  T183] 9pnet: (00000183) >>> TCLUNK fid 2 (try 0)
    [   32.444235][  T183] 9pnet: (00000183) >>> size=11 type: 120 tag: 0
    [   32.444364][  T183] 9pnet: (00000183) <<< size=7 type: 121 tag: 0
    [   32.444450][  T183] 9pnet: (00000183) <<< RCLUNK fid 2

In this case QEMU does hold a fd for the dir (since the dir is opened with
O_RDONLY, causing a TLOPEN), but as Christian mentioned, it always starts
the path walk from root, rather than using that fd.

QEMU git commit a759542a2c (today's master)

For the second case,
https://fileshare.maowtm.org/9pfs-landlock-fix/20250921/open_procselffd.c
reproduces it:

    (Host tmpfs exported as 9p to guest /tmp/9p)
    root@7-2-0-rc2-dev:/# ./open_procselffd /tmp/9p/dir/file
    [   24.243001][  T188] 9pnet: (00000188) >>> TWALK fids 1,2 nwname 1d wname[0] dir
    [   24.243305][  T188] 9pnet: (00000188) >>> size=22 type: 110 tag: 0
    [   24.243659][  T188] 9pnet: (00000188) <<< size=22 type: 111 tag: 0
    [   24.243855][  T188] 9pnet: (00000188) <<< RWALK nwqid 1:
    [   24.243983][  T188] 9pnet: (00000188) <<<     [0] 80.6d10.6a53fe73
    [   24.244124][  T188] 9pnet: (00000188) >>> TGETATTR fid 2, request_mask 6143
    [   24.244270][  T188] 9pnet: (00000188) >>> size=19 type: 24 tag: 0
    [   24.244460][  T188] 9pnet: (00000188) <<< size=160 type: 25 tag: 0
    [   24.244599][  T188] 9pnet: (00000188) <<< RGETATTR st_result_mask=6143
    [   24.244599][  T188] <<< qid=80.6d10.6a53fe73
    [   24.244599][  T188] <<< st_mode=000041e8 st_nlink=2
    [   24.244599][  T188] <<< st_uid=1000 st_gid=1000
    [   24.244599][  T188] <<< st_rdev=0 st_size=3c st_blksize=131072 st_blocks=0
    [   24.244599][  T188] <<< st_atime_sec=1783874216 st_atime_nsec=302475718
    [   24.244599][  T188] <<< st_mtime_sec=1783874163 st_mtime_nsec=254338030
    [   24.244599][  T188] <<< st_ctime_sec=1783875959 st_ctime_nsec=665487467
    [   24.244599][  T188] <<< st_btime_sec=0 st_btime_nsec=0
    [   24.244599][  T188] <<< st_gen=0 st_data_version=0
    [   24.245601][  T188] 9pnet: (00000188) >>> TWALK fids 2,3 nwname 1d wname[0] file
    [   24.245754][  T188] 9pnet: (00000188) >>> size=23 type: 110 tag: 0
    [   24.245936][  T188] 9pnet: (00000188) <<< size=22 type: 111 tag: 0
    [   24.246070][  T188] 9pnet: (00000188) <<< RWALK nwqid 1:
    [   24.246165][  T188] 9pnet: (00000188) <<<     [0] 0.6d11.6a53c273
    [   24.246287][  T188] 9pnet: (00000188) >>> TGETATTR fid 3, request_mask 6143
    [   24.246484][  T188] 9pnet: (00000188) >>> size=19 type: 24 tag: 0
    [   24.246661][  T188] 9pnet: (00000188) <<< size=160 type: 25 tag: 0
    [   24.246780][  T188] 9pnet: (00000188) <<< RGETATTR st_result_mask=6143
    [   24.246780][  T188] <<< qid=0.6d11.6a53c273
    [   24.246780][  T188] <<< st_mode=000081a0 st_nlink=1
    [   24.246780][  T188] <<< st_uid=1000 st_gid=1000
    [   24.246780][  T188] <<< st_rdev=0 st_size=0 st_blksize=131072 st_blocks=0
    [   24.246780][  T188] <<< st_atime_sec=1783875507 st_atime_nsec=502397563
    [   24.246780][  T188] <<< st_mtime_sec=1783874163 st_mtime_nsec=254338030
    [   24.246780][  T188] <<< st_ctime_sec=1783874163 st_ctime_nsec=254338030
    [   24.246780][  T188] <<< st_btime_sec=0 st_btime_nsec=0
    [   24.246780][  T188] <<< st_gen=0 st_data_version=0
    Opened /tmp/9p/dir/file with fd 3 (O_PATH)
    Press Enter to reopen

    (at this point dir/file is moved to dir/file2 on the host, then Enter is pressed here)
    (result is the same if instead dir is renamed)

    [   34.725233][  T188] 9pnet: (00000188) >>> TWALK fids 3,4 nwname 0d wname[0] (null)
    [   34.725619][  T188] 9pnet: (00000188) >>> size=17 type: 110 tag: 0
    [   34.726067][  T188] 9pnet: (00000188) <<< size=11 type: 7 tag: 0
    [   34.726241][  T188] 9pnet: (00000188) <<< RLERROR (-2)
    Failed to open /proc/self/fd/3: No such file or directory
    Press Enter to exit

With this case, there is no TLOPEN, only TWALK, so QEMU does not hold a fd
for the file.  (This means that, for Landlock, merely holding a fid is not
enough to prevent inode number reuse on QEMU)

> 
>> Also keep in mind: once the open file descriptor limit on host is exhausted,
>> QEMU is forced to close older open file desciptors to keep the QEMU process
>> alive. So this might still break what you are trying to achieve there.
>>
> 
> Correct.
> 
>> Having said that, I wonder whether it'd be simpler for server to track for
>> file tree changes (inotify API) and fix the pathes accordingly for host
>> side changes as well?
>>
> 
> The problem is how to have the guest know about such changes, e.g. in
> order to invalidate a stale cache entry. 9P doesn't provide any way for
> host->client notification.

I think there are two separate problems here - the server using inotify to
"fixup" its own tracked path of each fids, and the client being notified
of changes.  With what Christian suggested, the above two cases will not
break even without any client notification, since the client (in this case
the kernel) already re-uses previously obtained fids to avoid redoing the
path walk from root.

Having client notification might be useful for other cases tho.  Aside
from supporting things like inotify triggered from server-side
notification, it also looks like if a fd is passed to another user, on
access=user or access=client 9pfs will in fact re-do the path walk from
root (v9fs_fid_lookup_with_uid), and so having notification could let us
know what the expected path has changed to in order to correctly re-open a
(stale) dentry that may have been moved on the host.

> 
>> /Christian
>>
>>
> 
> Cheers,
> 

I think overall there are still largely two directions, and I'm unclear
which way is best, but some recent testing has made me realize that the
second approach might be simpler than I thought:

- One is to continue with this path-based approach implemented in this RFC
  series.  The main issue I can see of doing this is the somewhat unwieldy
  path tracking, and handling of parent renames (with the current
  implementation it would need to recursively update all child ino_paths).
  However, from a correctness point of view, inodeident=path proposed here
  really means that both the path, qid.path, and inode type has to match,
  and so the risk of "false inode matches" like the kind observed earlier,
  leading to the revert of 724a08450f74 ("fs/9p: simplify iget to remove
  unnecessary paths") and various related commits, should be low.

  This also has the benefit of making i/fanotify on a cache=none 9pfs work
  again (for local changes), aside from Landlock.

- The other is to have special handling in Landlock: Landlock would key
  its rules on 9pfs based on some 9p-exposed identifier, such as the
  fhandle as proposed by Dominique.  Through testing I realized that we
  could use st_gen to distinguish inodes with the same ino, and QEMU does
  expose the st_gen to the guest when the backing fs is something like
  ext4, so in fact this approach might be simplified (although I've only
  realized this today and probably need to try this out on more
  filesystems):

                                     v qid.path
                                       vvvvvvvv qid.version aka mtime
    [   78.617306][  T183] <<< qid=0.e.6a558647
    [   78.617306][  T183] <<< st_mode=000081a0 st_nlink=1
    [   78.617306][  T183] <<< st_uid=1000 st_gid=1000
    [   78.617306][  T183] <<< st_rdev=0 st_size=0 st_blksize=131072 st_blocks=0
    [   78.617306][  T183] <<< st_atime_sec=1783989831 st_atime_nsec=576593826
    [   78.617306][  T183] <<< st_mtime_sec=1783989831 st_mtime_nsec=576593826
    [   78.617306][  T183] <<< st_ctime_sec=1783989831 st_ctime_nsec=576593826
    [   78.617306][  T183] <<< st_btime_sec=0 st_btime_nsec=0
    [   78.617306][  T183] <<< st_gen=3634407333 st_data_version=0

  After rm + touch:

                                     v qid.path
                                       vvvvvvvv qid.version aka mtime
    [  100.234598][  T184] <<< qid=0.e.6a558659
    [  100.234598][  T184] <<< st_mode=000081a0 st_nlink=1
    [  100.234598][  T184] <<< st_uid=1000 st_gid=1000
    [  100.234598][  T184] <<< st_rdev=0 st_size=0 st_blksize=131072 st_blocks=0
    [  100.234598][  T184] <<< st_atime_sec=1783989849 st_atime_nsec=5600077
    [  100.234598][  T184] <<< st_mtime_sec=1783989849 st_mtime_nsec=5600077
    [  100.234598][  T184] <<< st_ctime_sec=1783989849 st_ctime_nsec=5600077
    [  100.234598][  T184] <<< st_btime_sec=0 st_btime_nsec=0
    [  100.234598][  T184] <<< st_gen=4062134779 st_data_version=0
                                      ^ this is different

  Previously I proposed that Landlock would need to hold a fid to keep the
  inode alive on the server side, to prevent inode number reuse when using
  qid.path as the rule key, but if the 9pfs-exposed fhandle includes this
  inode generation number, and Landlock uses that instead, then inode
  reuse is no longer an issue, without Landlock having to do anything
  special.

  (we can't use qid.version since that is mtime, which will change on
  modification / files added or removed in a directory)
  
Does anyone have preferences / suggestions on whether to keep going with
the path-tracking based approach (perhaps subject to figuring out a way to
handle parent renames), or an approach where Landlock simply stores the
fhandle (or (i_ino, i_generation (but this is u32 whereas st_gen within 9p
is u64))) as the rule key?

If I find some time over the next couple of weeks I will try out the
second approach since it might be turning out to be the simpler option,
but the drawback is that it doesn't enable i/fanotify on 9pfs, which I
originally hoped to achieve together with fixing Landlock on 9pfs.

Kind regards,
Tingmao
