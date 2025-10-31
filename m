Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BB24290D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924195; cv=none; b=toGJHuIlT2FGVQ+AQEHI7w8vmfJeMFVt2EZ1FgtF1Ti7/tr1HN2khS5BpG98xrIX7HGEg68R3+pJ+SKe5PZf9i8s+nB9OSuHmD7xVMSVXEK8e94nOKSYGHwIX6f8e12AldZkpGzCSsZZ/5/Wq4Bt4JuSPSkAgcH29dDXrXCVX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924195; c=relaxed/simple;
	bh=QYXe75Yh+yZ09byLhDF9yhftthum4CDB51HUlIPkhPY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tJGagm8CYm2mL1WuqChUZrVI7pAc61aVTftM3Pt0VtMn8DqWlYXz52VnfVVi8jAQ4vTT2NxseBRifWx+2HElsbtP5TdpBPB4tG37NiOMmgIXmAwtskK2ahmFeoqtjU1b6H+8dNBqzh00pRvgaHfZtUWGH/sSR6hb+IEg/b81Hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jy6thDzO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jy6thDzO"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761924187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27IEgfUKPZeIksBqlF8l79OSzqASR8q8aE6o0IGyKhQ=;
	b=jy6thDzOuar8GUGOiDze+whD6yp57TbQKhCV20GWb3oqRjTJgkuIpyqUb6k4Q0/cimTVN9
	8/9mnYXCAWm1wTXVIdZmruoIn54vnQPAY/v2Ld6E6NtgGtWQivs8HlYlEFwT5VeId9BF36
	hfgN6zx5VMWl9vzAfYApaxOub1SIcmQ=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251031125916.3b0c8b22@pumpkin>
Date: Fri, 31 Oct 2025 16:23:02 +0100
Cc: Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE3AAB5A-9AB9-49B6-BB67-FCB97CD5AF29@linux.dev>
References: <20251031110647.102728-2-thorsten.blum@linux.dev>
 <20251031125916.3b0c8b22@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 31. Oct 2025, at 13:59, David Laight wrote:
> Even if ex->major can be ~0 there are much cleaner ways of writing =
this code.

Thanks for pointing this out. Looking at the bigger picture makes it
clear that most of the code can actually be removed. What do you think
of this change?

Thanks,
Thorsten

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index a41f558f6fdd..cb845b1fad6b 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -244,7 +244,6 @@ static void devcgroup_css_free(struct =
cgroup_subsys_state *css)
#define DEVCG_DENY 2
#define DEVCG_LIST 3

-#define MAJMINLEN 13
#define ACCLEN 4

static void set_access(char *acc, short access)
@@ -270,19 +269,11 @@ static char type_to_char(short type)
	return 'X';
}

-static void set_majmin(char *str, unsigned m)
-{
-	if (m =3D=3D ~0)
-		strscpy(str, "*", MAJMINLEN);
-	else
-		snprintf(str, MAJMINLEN, "%u", m);
-}
-
static int devcgroup_seq_show(struct seq_file *m, void *v)
{
	struct dev_cgroup *devcgroup =3D css_to_devcgroup(seq_css(m));
	struct dev_exception_item *ex;
-	char maj[MAJMINLEN], min[MAJMINLEN], acc[ACCLEN];
+	char acc[ACCLEN];

	rcu_read_lock();
	/*
@@ -293,17 +284,12 @@ static int devcgroup_seq_show(struct seq_file *m, =
void *v)
	 */
	if (devcgroup->behavior =3D=3D DEVCG_DEFAULT_ALLOW) {
		set_access(acc, DEVCG_ACC_MASK);
-		set_majmin(maj, ~0);
-		set_majmin(min, ~0);
-		seq_printf(m, "%c %s:%s %s\n", =
type_to_char(DEVCG_DEV_ALL),
-			   maj, min, acc);
+		seq_printf(m, "%c *:* %s\n", =
type_to_char(DEVCG_DEV_ALL), acc);
	} else {
		list_for_each_entry_rcu(ex, &devcgroup->exceptions, =
list) {
			set_access(acc, ex->access);
-			set_majmin(maj, ex->major);
-			set_majmin(min, ex->minor);
-			seq_printf(m, "%c %s:%s %s\n", =
type_to_char(ex->type),
-				   maj, min, acc);
+			seq_printf(m, "%c %u:%u %s\n", =
type_to_char(ex->type),
+				   ex->major, ex->minor, acc);
		}
	}
	rcu_read_unlock();

