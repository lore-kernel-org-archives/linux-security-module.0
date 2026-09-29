Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CF560AAF;
	Tue, 29 Sep 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708054; cv=none; b=h4BJsPk7WX7xcvzX+eHsw3D0/QpsgaXyzrll4M7iyMfIrVCxXRSS4OXUbsY5mzUbnjkjoF9o7GdFM7BbLKHcSNyTJK3LCdCTgp48IoWW/Mgq4tcZKDBBbjYz01T8QcHC24JmzZCYIewHwboYV69+TRtYqgOUltZ2FRBWY54H+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708054; c=relaxed/simple;
	bh=/1f4drz8OsTh3y47BMEw2ZHfRJOVraN1laDiePw5wsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7Ed9tAn5wBk6iztBVmp5FclGAkt5g+pTPtqstIuMbne0H/rwnD7X0dW2TgE7n/mOvM7xVlesbwLmGZVzMu8CbvJHRicwgDADvTDWcdV3mf4B7fV//qnvOpsOB/OcfUYCT9XvZdVLBNTzNlkcxUtp2V1mVEWpMukHXx+yAjc7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=Or+oWVD0; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="Or+oWVD0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=8LcRccDlccCTgekcmrr1vGcCIVUADcG5V0KsCOj41ag=; b=Or+oWVD0FMUd3cwwZt4ewM/LxS
	lCJkev9/NgUlb360TT+xvllPDApBXwLsGE0xSTFIpQa2RYavIVToVTMMQf2sbGNXoZpk92NuI8/Rv
	pBJpKq1aUTnssJMTe/G/UOq2rmx2ODKKrwrvI12Vd2jBrn9la60AU/eCWecDbf84LA6Drme9iud2N
	0aYVl0I7SuZsPhGsKttCdZiksngXqgkq0qn6cxE9zttKdPTAkr6pq4WN6XMqXfhePHpIDql1mBnlt
	MJk4RcH13XGAP2ah+ZMmQ1XNALVRfZ7KIGRRgXzRRX9orvTQeLxQMshDbmhZkRUFoHs3/Z4VJOWT6
	9KP39+sw==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xBcxt-0000000GSRB-0gqc;
	Tue, 29 Sep 2026 20:54:09 +0200
Date: Tue, 29 Sep 2026 20:54:08 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Maciek Borzecki <maciek.borzecki@gmail.com>
Cc: apparmor@lists.ubuntu.com, John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: handle NULL peer label in AF_UNIX context
 updates
Message-ID: <arwJUDS1vbUq_KKT@aurel32.net>
Mail-Followup-To: Maciek Borzecki <maciek.borzecki@gmail.com>,
	apparmor@lists.ubuntu.com,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9a2d420a1757516f1e9ad4e9a0e9f17b9ba92c72.1789628002.git.maciek.borzecki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2d420a1757516f1e9ad4e9a0e9f17b9ba92c72.1789628002.git.maciek.borzecki@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi,

On 2026-09-17 09:15, Maciek Borzecki wrote:
> When a confined process performs the first file permission revalidation on
> an AF_UNIX socket, both update_sk_ctx() and update_peer_ctx() can be called
> before the socket's peer label cache (ctx->peer) has been populated. In
> those cases they pass NULL as a label argument to aa_label_is_subset() or
> aa_label_merge(), which immediately dereferences label->size and causes an
> Oops:
> 
>   RIP: __aa_label_next_not_in_set+0xd/0x110
>   CR2: 000000000000004c
>   Call Trace:
>     aa_label_is_subset
>     aa_unix_file_perm
>     aa_file_perm
>     apparmor_file_permission
>     security_file_permission
>     rw_verify_area
>     vfs_write
>     ksys_write
> 
> Observed on Arch Linux kernels 7.2.4-arch1-2 and 7.2.6-arch2-1, triggered
> by snapd unit tests writing to a connected AF_UNIX socket. The issue
> persists across those stable updates.
> 

It appears to be the same issue as reported here:
https://bugs.debian.org/1145111

And a patch that looks similar to yours has already been posted:
https://lore.kernel.org/20260824155822.9214-1-maxime.belair@canonical.com

As it seems you have looked at the bug in details, you can maybe comment 
it and add a Tested-by: and/or Reviewed-by:, that might help to make 
things progress.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
