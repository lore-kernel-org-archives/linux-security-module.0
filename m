Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B42F6184
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408421; cv=none; b=GI+//SXNFnClvdmkJwowLAYSpnvhjLh5Klez3TWdSpQn2S34+3ThtSWxBfr0nR5Re9h7xaYEfolPF7AfphmZv+TWTr7MzCKNoVuz1HwWdlJ4ZPE4FmnW5UGJPXeIMOfH5fs+5eujMMt2ntdArGxb4M9JFazT0V/qLSD/iTvQXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408421; c=relaxed/simple;
	bh=J9VSf4GFSRnCeM/zRTTO3OcekKEgf2VSDADW3OuMymE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoSRZbPz9MwuxS8EWA8tBHwK/h/9BAodE8fOzLfRz8NO81HiC77z2qQ/l8c2pE1Apieq8kPx9avMty0Zha4Wg6jt5aDOeKoBZS1k3OK5O3yqHWCqRbx6uEiGUYvHtUUOZft9jq9yyPhDeTNDUjzF6jlpgQTorIVMiANudnDjdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T60VaSKU; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T60VaSKU"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d195166b2cso1929313a34.3
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770408420; x=1771013220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3wE/nOGLvc3QkX9UGDprKILAWky/nGcYsK1Fu7jX+4=;
        b=T60VaSKUIsAO9mkrJBLF5+7rAumRBGzDL/ZOfvAFJzzAnw7DWHKRCmiScn+gxyBlUA
         nyJWvwW+PrD4scXR7zmwXOT4f0daQMnxXtMqmG3gqaVVp9tYJ23xDjat13C8ia48qeQe
         M4/B/2eSeiahhOVjKMjvDtQuu4jIhhYBB3H7wvBOs3YuS0hyRkP3jecTk9Cro0m8LCeG
         2vhM20XT7MtzFxTz/g3B3EfY3JZ1NC71LgwaYVo/KhfOh9+ZfUPPRFCqRHrZ1VFwV5Cw
         C7sy4FuFd4YwIkAq5o2cPrBAuudVNsR3BiTyo+SwovRIVd8qf8LaslTt6rKhqeyCxCzk
         yf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408420; x=1771013220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3wE/nOGLvc3QkX9UGDprKILAWky/nGcYsK1Fu7jX+4=;
        b=ggxolHs05UlWyzjZ0xEnAarybO3cg1eH9mMUdsceguKsx3t3g9m8fGgQQ82Q0ofN88
         aeSCSE+3kmDAQMmOnB+4DtkUTtmFNIpKdUxxN8oZOr0mm0RVFBgHhje5NwRuV3BhW1c8
         x7bziUIRFLlo+L9DGbzFPGP8h1enY2LeGrsxpaUIPHNKi+MlWLkRcGZp6VfryL3NPCIJ
         EzJ1f9KQkIUJp+oRnjzuHPZ5NoQEir4FqzGVx3sajT34nXpPezC0L0/PNxFwTeAP/bSQ
         RoX3vRgj960aM+PKleLxpbejrphlDW5abpQdfC9UkBurS5K+R3LwU2CsXTdk6Wi/ZAee
         twvA==
X-Forwarded-Encrypted: i=1; AJvYcCX1+Va7Wahp3qLmd25DzkEardSv4Dvb1l4seicgKuzspvL/uDvmqkblah9npXm8mBFLUBxLjQTHybr91uNp6m1cMxzZprA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6GzNJJz2DBvA/tzZsXeCXfmFw2An/D8Bkfn2XY3B2rvULmct
	7CvS4poeR1GqRBXn26D0SNsWs9Y8X86g+cq7YHkjkEoJyXwIoix9pvSDq4SjZjgb48Q=
X-Gm-Gg: AZuq6aLi1+yzVj0zUDKGDLO3XJ9x0xrtKatqwwRFxx8pCPnBYVn+MTLUUSIS0UsF9A4
	kinncNJBUkYt7hrI1gvDOVZu3VRTlhkZcq+vxwacKDcsmCFk0aUsXzI8m0c/i97b77LRqcJdkXf
	Hvgf6MWsGBdgOZ2/GsLxCAwlVtXaZmamstQ3CDO2X1pxhBcpX9/HWFRqrXxhcUod4yOCGTH75o7
	iPDzemNC3syQ9UixRsTvZE+OKv/StbUlUG39rX7AEogmcVOW3035GRA6sH3S024dH7xFFMk75IL
	nd+mMneoQpvLPConRNpkesWA63o/fRP5YTiJAYHNeF3mvsXuzIm+Hjno3P5oYwwoCB7R5AYTQMa
	we0qdbwV8iGuvEN4F69IN8s1MppaD4VmUgWgfdc8EwalPpF9D4+mZ1m7Ymva/BR4LUA==
X-Received: by 2002:a05:6830:6f47:b0:7c7:6043:dd87 with SMTP id 46e09a7af769-7d4643ebfb8mr2045525a34.6.1770408420345;
        Fri, 06 Feb 2026 12:07:00 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:4e6::7d:6a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470da04sm2246603a34.7.2026.02.06.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 12:06:59 -0800 (PST)
Date: Fri, 6 Feb 2026 14:06:57 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v5 3/3] ima: Use kstat.ctime as a fallback change
 detection for stacked fs
Message-ID: <aYZJ4Y33oRRk5Drs@CMGLRV3>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
 <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
 <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>
 <aYO4fj0Uw0aUWXOX@CMGLRV3>
 <6f82d5dc6b499ecd03c985d6de20de94fea04cfe.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f82d5dc6b499ecd03c985d6de20de94fea04cfe.camel@linux.ibm.com>

On Wed, Feb 04, 2026 at 11:26:27PM -0500, Mimi Zohar wrote:
> On Wed, 2026-02-04 at 15:22 -0600, Frederick Lawler wrote:
> > That said, I think Mimi pointed out in an email [2] where multi-grain
> > file systems are impacted regardless of stacked fs or not due to the last
> > writer check.
> > 
> > I don't recall coming across that in my tests, but perhaps I did that
> > specific test wrong? To be sure, I created the C program, and on the VM,
> > created a XFS disk, mounted it on loopback, ran the rdwr program on
> > "somefile" multiple times, and only got 1 audit log for it, until I
> > mutated it with touch, and only got 2 hits: original + after mutation
> > after running the program multiple times. 
> > 
> > I'm not sure what's going on there, so I'll look into that a bit more,
> > but so far the impact is stacked file systems & multigrain ctime AFAIK.
> 
> Make sure you're testing without your patch set applied or at least the last
> patch.
> 

I'm still not sure what went wrong with my test suite, but spinning up a
VM similar to Mimi's, I was able to reproduce the last writer issue. I
used patch 1 as a baseline because that's noop from base 6.19, and used
that function as a convenient trace point.

And, then running the attached example test for stacked FS works as
expected on both patches 1 (multiple log messages) & 3 (just one log
message).

I left out the dump_stack() in integrity_inode_attrs_stat_change()
for readability in these results. For Mimi's test, we just see
calls into ima_check_last_writer(), and for the attached sample
in 0/0, we get the calls straight from process_measurement() for
stacked fs. Running Mimi's and then attached in that order, I get
double the logs because the FILE_CHECK is hitting the last writer,
and we get the process_measurement() for the binary run.

Based on all of this, I can drop the stacked FS wording in the patch
descriptions, and keep it all focused that the change_cookie semantics
have been changed for multigrain file systems.

Results:

PATCH 1/3

[root@localhost ~]# ./mimi.sh
filename: /usr/bin/date-20260206140427
filename: /usr/bin/date-20260206140427
filename: /usr/bin/date-20260206140427
FAIL: Expected 1 audit event, but found 3.

[   26.033572] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=0 change_cookie=0
[   26.034372] ima: fred: ima_check_last_writer: must measure file: "/usr/bin/date-20260206140427"
[   26.037453] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=0 change_cookie=0
[   26.038425] ima: fred: ima_check_last_writer: must measure file: "/usr/bin/date-20260206140427"
[   26.039821] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=0 change_cookie=0
[   26.041383] ima: fred: ima_check_last_writer: must measure file: "/usr/bin/date-20260206140427"

[root@localhost fred-tests]# ./simple-fedora.sh
314572800 bytes (315 MB, 300 MiB) copied, 0.132908 s, 2.4 GB/s
Fri Feb  6 14:56:18 EST 2026
Fri Feb  6 14:56:18 EST 2026
Fri Feb  6 14:56:18 EST 2026
Fri Feb  6 14:56:18 EST 2026
FAIL: Expected 1 audit event, but found 4.

Note: Does not have dmesg output because this patch didn't put the trace
function into integrity_inode_attrs_changed().

PATCH 3/3
[root@localhost ~]# ./mimi.sh
filename: /usr/bin/date-20260206140141
filename: /usr/bin/date-20260206140141
filename: /usr/bin/date-20260206140141
PASS: Found exactly 1 audit event.

[   17.191235] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=1770404501462431821 change_cookie=0
[   17.192213] fred: integrity_inode_attrs_stat_changed result_mask=128 (ctime) version=1770404501462431821 ctime=1770404501462431821
[   17.196325] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=1770404501462431821 change_cookie=0
[   17.197380] fred: integrity_inode_attrs_stat_changed result_mask=128 (ctime) version=1770404501462431821 ctime=1770404501462431821
[   17.199750] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=1770404501462431821 change_cookie=0
[   17.200682] fred: integrity_inode_attrs_stat_changed result_mask=128 (ctime) version=1770404501462431821 ctime=1770404501462431821

[root@localhost fred-tests]# ./simple-fedora.sh
Fri Feb  6 14:53:30 EST 2026
Fri Feb  6 14:53:30 EST 2026
Fri Feb  6 14:53:30 EST 2026
Fri Feb  6 14:53:30 EST 2026
PASS: Found exactly 1 audit event.

[   23.315358] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=1770407920086616962 change_cookie=0
[   23.328978] fred: integrity_inode_attrs_stat_changed result_mask=128 (ctime) version=1770407920086616962 ctime=1770407920086616962
[   23.332122] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=1770407920086616962 change_cookie=0
[   23.347162] fred: integrity_inode_attrs_stat_changed result_mask=128 (ctime) version=1770407920086616962 ctime=1770407920086616962
[   23.352931] fred: integrity_inode_attrs_stat_changed result_mask=0 (change cookie) version=1770407920086616962 change_cookie=0
[   23.368026] fred: integrity_inode_attrs_stat_changed result_mask=128 (ctime) version=1770407920086616962 ctime=1770407920086616962

Note that the in stacked FS case, process_measurement() skipped the check
for attrs changed, and skipped to measuring. Subsequent calls into
process_measurement() hits the integrity_inode_attrs_stat_changed().

