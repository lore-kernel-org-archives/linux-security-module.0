Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80124BE420
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010899; cv=none; b=tWVEtkQY4+dpwvlTGd7y//hwFM0BAZC06MxxhhCAnYqJxQis+c1VJ+Ib4Zqn61G6pdf+Q1fsfnSnTshYXSAq/Nra9bNC1rVKBVHmFP62AqftuELd8wm/wjZ1q+q0AW+BeMt1GrVBmMiP1L8HXTVb4KsL5ShmA3NBenAmDp9nU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010899; c=relaxed/simple;
	bh=yz/ljsX0zsmZtZUSzyzVMVFxg8xWAZZITJvfwDjnZoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrDb/dGSIUtfXqUnJR7nPUPcSCfwK7QGWz0eoXxGcQzB5t0ejHMFN1OriLJYU7EVUOJzgtYBOnrCMej8lThoGXZUOIbzFdUhAsjefKxxZK7sL8P8ARTFOoSvGE/fdohLZfOG+sNPVooRcFq5jSr6kw5HnFcZRBbdnB6mlGmrlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=I2cAzsDJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="I2cAzsDJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9178aabd30dso45460166d6.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010897; x=1792615697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O6PJ6Vsu/6xTVjkvaAXTBm2OKjtFf/wfZcImncZuPSs=;
        b=I2cAzsDJpEiJeka7tG7Ps8mxGceI9GPSrOxZSiqBQQhM2mq7Lzs1LH573HWDBOcD8G
         ZFd0WExaCcp3URILazR/uIl54BOJsBIyr0Z8lW1L6VTc5Lza0IOBFHC5lfHjPtkkDK33
         B5COJYucPOHnsedIKado0RLkCp7BWq3EWFNpnXNykkmb0PR7SyMp7jxgKLky5k0efNxj
         FrPCVw+LnQpunHDu6XEqzy8cTWW2BDDxV8DSiLfC36/Fael2vOUkJR84VhGr/yWxSXDH
         jZi8+P3BiKdTztuuJLe0ORfBqfg0pVSrSKROSZnIgVBh+3nrDNg7NP6gLi59mFbkPKkt
         Godw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010897; x=1792615697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6PJ6Vsu/6xTVjkvaAXTBm2OKjtFf/wfZcImncZuPSs=;
        b=P0MS94atjJ2GbwAdVI25Y3ZswLv7LpIFhMkqeNhLniA9MTpnepU0AehQ86NJxJrciN
         prLsK1TX+bKO/uSFD7ehDdweMrzwzHWJWclY9Ac6RkrjMzfIxzPmTNoIpzv6o/4VJjWi
         NrA/vplMD4ll4gbjYqLKd/e9wflC1KKs9r3JoURHC73lsGEcDRGHTX8rnMtxhjz7DM+X
         7yijMDflWdibwK7sgS5fQh4W3cDbvtzWcReegsci/5jCpQjBcR8Wfdla1z6lkWy73Juj
         y2+fI+YJ9zoDO8or+VX1YYRFvXdOB+eqn16qkkZkZ794aE+wwQYo0EQutlvQ7wylpC1o
         6XQg==
X-Forwarded-Encrypted: i=1; AKwUvBy78EoBJNszfTX8uo8bFPafBmNxFIGpCYuBPKSnEId0r8DKQOuOXZp0CcVX5MxYU75GkdAj/NXZ5o2UukO/ETu+oifln7A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH/SqeAS+diK6D7P5234BtXRinEK476jZv9VLRE6/sl4Ckzkmr
	MR8dxFlDb/FotEyM19W5zPqgjrYewxmze5DKNgiMoQWqttGi+SAYzkFxRqw+qTLQQr8=
X-Gm-Gg: AYBFou303lwf2udWXdOEsw/5voGI6oVkZ228BBdPDGwhSy1gWGEMzlYv8rmkEKu9sTc
	nhZu5XpVYzZLLiLcX44yerIdbQdSwZU0GgD7wrq0jUGeA7RG1ruGarnYALoCg0xwKhKoXMiFxKF
	XJLOQlf7ZS0QxQO5sNReVVh2cln6dz/FJ2cyjCAmmjILsATPWhc1KbypAWh5ZXBXwEb39P2Lnku
	8nhUfeliusQn7SIrODzCq/zZUaHnThJFQNBLcLAReVnqZLCbbvVYgLrvho+wemDiAftC+eSCfCu
	EmRPDxQjg/cdv2Yan7+ef/xzCmapfgwSkNG4Wk3eifkyVg3wPTKk7bq153YiZ9BZHOp+9gvrqli
	WmjYsVLEDmmeBYEoa+kMRcn/hvMPGqghD2ZF+qULU5x5EJ35gF0koQa83nRlhkHW8eTkYOvJc0I
	6uTcnCL5heesSlqTJEFJrBsn/5iNiM4YpoFj3UfwxLH0W5Whs51Njf9TXpyW9XZtnCEgXj2Ed+Z
	rL4GLSXUcOP0TM=
X-Received: by 2002:a05:620a:a7dd:10b0:93e:f0b9:505a with SMTP id af79cd13be357-93ef0b95671mr867809385a.58.1792010896728;
        Wed, 14 Oct 2026 13:48:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50080aasm588523985a.14.2026.10.14.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:49 +0000
Subject: [PATCH v2 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-4-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
In-Reply-To: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=3016;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yz/ljsX0zsmZtZUSzyzVMVFxg8xWAZZITJvfwDjnZoA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QItvq5f13UpqrDRjEY0E2EsO4PlV1hqDHH2LfE8qTXjZ/Prj/Fa55wgA+40Z7Y6Ksz5LPam3uTB
 1mNaPRQBY1A4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index f52f1c7a87be..2cae4354aeae 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -644,10 +644,24 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

