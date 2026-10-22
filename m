Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693721;
	b=XNm53ZPzdvh3tAo4XwTtxI6ilso/riEcqhpp5e8wIgo1Sdm+O8wjuAIa1S5AhBhIDrxJ
	 AFKYKVvWp7RZwTn+Eoe50CJHxcvrB6O6aLdfT5dOT10P56+7mFRz2nGKowNEwi4PqT60Y
	 yRGBFDhLT4nQQLKU4z8lT42egewlmRl8yEm4/G+dETBl5hGrH588+DUXPtSlkLFLK383q
	 X2XHA77+3I+vptJALq3YjnxSXbsFGftTB+qjjbqCIgnKuyWU0BYYsLOzae6Qh6eTdDEPU
	 3Oj0n5LpmFViNPoy+KMSEY9kJu5f45qtpMr5Dsg3hvUgtsu1PDIZ0Bd1IqbETd6U6/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693721;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JYh+FSmeD5zBdSGmLXfoWsuKx9ehvUO73Rr6qnSc3X8=;
	b=yuZ/2mKs+xJPSkAeU4LWkk55Yrkkn6KTa1fWO+Dlqa9yOs6N1fMH3frM3PwccJfhnT2t
	 qPaxjBr4qnGNkQ3L2eyrIziNzRKwBfc8SoCQ+cJo2/YD/xty/hitefRe0e6yxQ+7UMzt6
	 jQ3bIBr/OdqVmRFnFzBU87jp734g3mW11patyxDJfDkMLc+6y5xZrnIuqaaV0DNwfEEvv
	 evpx5kx8+cYhYorFGLF29+bl5WlXZrW28Kympb7LKu5fz8rYvc4KfbE0XdRbKaaARIqWm
	 b44GvKh1ySmTeZmlMjLs12/riL1djYVT0A7OKLKEIkuklJc54ULT4N4ExuGXXwjXoOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=FB4rIzmo;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE49606A329
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE49606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=FB4rIzmo
Received: from macsyma.thunk.org (pool-108-26-156-23.bstnma.fios.verizon.net [108.26.156.23])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 69MIRtlq008340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1792693680; bh=JYh+FSmeD5zBdSGmLXfoWsuKx9ehvUO73Rr6qnSc3X8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=FB4rIzmodCuc/ai76PzcPn8NKTCLCBgJQn5lG4OsNurD082LpzxvtWFDvX0WpozMi
	 G5Wxrp5EKZivFppsyR/34R27Liveb8SHZHVPaUoS8ZK0SZqi5QIowbJZ3A3OxbM4VC
	 T6wusZBLcMx4TA37NCtnpi9VcygARe/ydMqEQL+dUU2EOTWaGTS6Vg7HOcXefp/15T
	 d7nP4c/UgU10vdDcWJP9aCfO9onPi6Wq2o/TdsUsdoFN9dfgwzIj5Cp6zqZxHaVWNY
	 x9vDg8JooiFE5P2IxXk6tkIe6BLRPcasmFTfgbGaiWHz4u1SVqCZ6O7DWx0DCQCJGP
	 /VtU8vRIAggOg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 96FCB22114B9; Thu, 22 Oct 2026 14:26:55 -0400 (EDT)
Date: Thu, 22 Oct 2026 14:26:55 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jan Koester <jan.koester@tuxist.de>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, netdev@vger.kernel.org,
        audit@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/41] UUID and GUID user and group ids (*_r
 system calls)
Message-ID: <atpNJINlFhQ0M3Y6@mit.edu>
References: <cover.1792552161.git.jan.koester@tuxist.de>
 <018ca365-ce9b-424c-b600-bd9c8aefc9a1@schaufler-ca.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018ca365-ce9b-424c-b600-bd9c8aefc9a1@schaufler-ca.com>

On Thu, Oct 22, 2026 at 10:00:16AM -0500, Casey Schaufler wrote:
> 
> I can't see this being acceptable for a variety of reasons, including
> but not limited to performance and configuration complexity. It's a
> general solution for a special case or two, and the impact is significant.

Yeah. I agree it's a non-starter.  For one thing, it requires
replacing every single system call which uses a 32-bit uid or gid ---
either as an input parameter, a return value, or in a structure, such
as, "struct stat".  It also requires making breaking changes into
on-disk file formats that use a uid --- for example, /etc/passwd,
/etc/group, utmp/wtmp, etc.  If it will also break compatibility with
remote file systems that don't use a Windows SID --- e.g., nfsv3, AFS,
etc.  And that's before we even get to breaking things like tar files, etc.

I'll also note that customers that are most likely to need to use the
abominationm of Windows SIDs are also those that are likely to be
using proprietary third party binaries --- you know, silly things like
SAP R/3, Oracle Enterprise Database, db2, etc.  And if you use Windows
SIDs as user id's in your /etc/passwd, then binaries that are still
using the traditional system calls will get the overflow 32-bit number
--- and break.

I suspect it will be much more useful to simply add a supplementary
user id and group id which is only used by those file systems that
*care* about Windows SID's, and assume that everything else will use
true, traditional Unix uids and gids.  I also suspect that we should
be stashing the supplementary id's as extended attributes for the file
systems.  That way we can much more quickly and easily add support to
ext4, xfs, btrfs, etc., as file systems that can be used as backing
stores for NFSv4 and CIFS for those (few) environments that care about
Windows SID's.

						- Ted

P.S., From my perspective, Windows SID's are actually the legacy
ID's. especially as more and more people flee Microslop's Windows 11
and moving to Linux and MacOS.  :-)
