Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378851FF1AD
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916320; cv=none; b=LOkRV4EGkoSWSiVNETxX174ShUpf2qzuIXjlmD49djc+kTNey6BuaIBbSQD1bnE//IN0O+/tQNl1Xtdm5OiNVytAvF/grhQDQ2QT6gVlAc/VdsE/59K+U1PhjZ2i04JHjnVDRol56Ux9Mru4ETBm/rRuTf/DQqcx1ucWc9zyVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916320; c=relaxed/simple;
	bh=FjnuknUKHafj9VjcTmGKowDO4oahvWxzLheWbZonOt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tJVBGgmTm3py3U0YSyqswi9NH5zY04tsw+GJXrXHA934D+0djyti4gBNtxfpSv/+aPXTWXOQx3jAguuQkgIyyxymSJmiej1ZkOXkwYDZOjv8bF0WuIqAQ1ZuguMHVV6v+nNPqMV2qQEyeDt8tBDS3gxGHDCF9LUjSXkDeYPtAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUgFmsxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUgFmsxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757916317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omBBC34VXd5M1CEthfLS/UAjyzULL/tObmzB8px4Cho=;
	b=KUgFmsxPbGNPkbGtA/Ez6FMl1+i5IN50kJQCqdtg5twtLlgDPz31W4pmkHJv7dNibqq9WT
	X79qOMXWph5c+ULQX6cT+/a4/ZYj0AhKxzJXsRbWgfkQSBqpRNBA7o9Ro1BU9r9PUPqc5G
	fpr+yzYheA6RcWIx3eBSTaocUEiTNi4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-gI1d4KYTMAWa4WQCf1ZE1Q-1; Mon, 15 Sep 2025 02:05:15 -0400
X-MC-Unique: gI1d4KYTMAWa4WQCf1ZE1Q-1
X-Mimecast-MFC-AGG-ID: gI1d4KYTMAWa4WQCf1ZE1Q_1757916315
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32df881dce2so2272266a91.2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Sep 2025 23:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916314; x=1758521114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omBBC34VXd5M1CEthfLS/UAjyzULL/tObmzB8px4Cho=;
        b=cNYTnKEWzhMuvJUJeUVwGddNRCcUsI7b66utwo5z0RklwC26T6zWasdNX7Q/sQTrNd
         MD71LsBc+0VLeJiPo8a2B8fr4RetSVA9C+8FO3tzUfE9EAF8QY8o4hqoUwS8eBlGierN
         6mjc9YfsHqyOflgTfAbcsKRqbKd8p+6GFgeQkuBOPfjlokU623ruFi27asuyzT0i2x3X
         hm5HCUMVVjj44c0C/uSkJzKOR3Sln3Xu5EAEAy4rhn8cMRecSpPTvoxsYy9PR5VJgi3h
         WdRs5zDgpd0UrSCxwT8Fu7MLcv5E3FCQmGN4063c3ImQg1azh3NAb6PVNbu88CVtKedL
         7L1w==
X-Forwarded-Encrypted: i=1; AJvYcCUVnvpL0IfKmVpm7EUPvEReDEpJQnd9EgyAHtEskNgpGYLHMM5U3JBJG89U0nz5o266Hsnkp+Hp+VThgTZhZn9rbeaA8T0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6nSd4wP3DlBfE+QguMkIqzfTT1GkqM8+sYK7xJaQYrtfRmuy
	r9/cv/SJHccPCBTmeHAV4FNli6DudUgB9m2DATJcclJgy1UBpIxJCWrus3Q4Cl/CR3DYZMOx5qa
	Ho1BSbCwvkQQEWPnbU4prmAH+7LnK65pg/uXvanxBTEwIHQ/daOhwS8cWHILPG1e82Z4e7LTOF5
	FWOQ==
X-Gm-Gg: ASbGncu7U3QAYc39kzvsbwzpLuKx0ZFiTRZhnEL5lJHrN0NNfKFhN4nMsoUzQNwVeZi
	3v2T+fhWqYlQ0K9EhYaTdbUz9+LU+CqlfvRyxOdNTJIho9c8lI/GrWGNY7I0LpUKO0BEeSgJv6r
	/lREwH1HPLxoXmJpr7RWScL2hyJZ+h7KJF9Pr+dH3fIkXhrTW7+DgLPg9IwaPAfsgdZJdOgFriL
	Ae8XvLcGschuOLXrCv3U0Hrhvfnh5HmnN/gIUsWRfY+pQN1H7+FBG7XPECjcqcIk+8M1PIN0ml6
	DBqmYmCatWr9H7ulmVp8QrhpNrzTbek=
X-Received: by 2002:a17:903:37cd:b0:25b:f1f3:815f with SMTP id d9443c01a7336-25d2782cda6mr166987665ad.58.1757916314541;
        Sun, 14 Sep 2025 23:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNlG6tjmW8hOH++0qfJ78+vVgyjSBUaQc7oR1me/YHP9gwQwOcHBaCT0XwJ/bVU3GcEaMzkA==
X-Received: by 2002:a17:903:37cd:b0:25b:f1f3:815f with SMTP id d9443c01a7336-25d2782cda6mr166987255ad.58.1757916314118;
        Sun, 14 Sep 2025 23:05:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264277e8bc2sm35628675ad.138.2025.09.14.23.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:05:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:03:32 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <asadtbf7itw2343rjwvqfdvhmofhu7k6n4vsos2lojt6gqtudv@l7cgdsfbuuku>
References: <20250902042515.759750-1-coxu@redhat.com>
 <20250908105825.1573222-1-coxu@redhat.com>
 <7790048d4dc468792b428e80ceae7261a97a896d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7790048d4dc468792b428e80ceae7261a97a896d.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VItEp1vc9FhKiNXGGHB1Pf9UwiRjwMxeULiXMZwWUx8_1757916315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 10, 2025 at 08:21:03AM -0400, Mimi Zohar wrote:
>On Mon, 2025-09-08 at 18:58 +0800, Coiby Xu wrote:
>> Currently when both IMA and EVM are in fix mode, the IMA signature will
>> be reset to IMA hash if a program first stores IMA signature in
>> security.ima and then sets security.selinux for a file.
>
>The problem description should be generic.
>
>-> and then writes some other security xattr for the file.

Good advice! I've applied it to v3 with a slight change,
"... then writes/removes some other security xattr" in v3,


>
>Start a new paragraph here for the example.
>> For example, on
>> Fedora, after booting the kernel with "ima_appraise=fix evm=fix
>> ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
>> package will not make good reference IMA signature generated. Instead
>> IMA hash is generated,
>>     # getfattr -m - -d -e hex /usr/bin/bash
>>     # file: usr/bin/bash
>>     security.ima=0x0404...
>>
>> This happens because when setting selinux.selinux, the IMA_DIGSIG flag
>> that had been set early was cleared. As a result, IMA hash is generated
>> when the file is closed.
>
>Start a new paragraph here, adding a sentence describing the solution to the
>problem. For example,
>
>Prevent replacing the IMA file signature with a file hash, by preventing the
>IMA_DIGSIG flag from being reset.

Thanks for the suggestion, applied to v3.

>
>>
>> Here's a minimal C reproducer,
>>
>>     #include <stdio.h>
>>     #include <sys/xattr.h>
>>     #include <fcntl.h>
>>     #include <unistd.h>
>>     #include <string.h>
>>     #include <stdlib.h>
>>
>>     int main() {
>>         const char* file_path = "/usr/sbin/test_binary";
>>         const char* hex_string = "030204d33204490066306402304";
>>         int length = strlen(hex_string);
>>         char* ima_attr_value;
>>         int fd;
>>
>>         fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
>>         if (fd == -1) {
>>             perror("Error opening file");
>>             return 1;
>>         }
>>
>>         ima_attr_value = (char*)malloc(length / 2 );
>>         for (int i = 0, j = 0; i < length; i += 2, j++) {
>>             sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
>>         }
>>
>>         if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         const char* selinux_value= "system_u:object_r:bin_t:s0";
>>         if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         close(fd);
>>
>>         return 0;
>>     }
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  The updated patch looks good.  Have you looked at the other
>calls to ima_reset_appraise_flags() to make sure they don't need to be adjusted?

Great question! I've updated the other two places in v3 which can
address two additional cases,
- remove xattr like security.evm
- set/remove ACL

Note I tried to write a C program to set/remove ACL but somehow the C
version of "setfacl -m u:test:r" always lead to "acl_set_fd: Invalid
argument". I bypass this issue by setting system.posix_acl_access xattr
directly. We can get the value by "getfattr -m system.posix_acl_access
-d -e hex" after "setfacl -m u:test:r /usr/sbin/test_binary".

>
>thanks,
>
>Mimi
>
>> ---
>>  security/integrity/ima/ima_appraise.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..4e4750ea41ad 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
>>  	return 0;
>>  }
>>
>> +/*
>> + * ima_reset_appraise_flags - reset ima_iint_cache flags
>> + *
>> + * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
>> + *          0: clear IMA_DIGSIG
>> + *          1: set IMA_DIGSIG
>> + *         -1: don't change IMA_DIGSIG
>> + *
>> + */
>>  static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  {
>>  	struct ima_iint_cache *iint;
>> @@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  		return;
>>  	iint->measured_pcrs = 0;
>>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
>> -	if (digsig)
>> +	if (digsig == 1)
>>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>> -	else
>> +	else if (digsig == 0)
>>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>>  }
>>
>> @@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>  		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
>>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
>>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>> +	} else {
>> +		digsig = -1;
>>  	}
>>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
>>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>

-- 
Best regards,
Coiby

