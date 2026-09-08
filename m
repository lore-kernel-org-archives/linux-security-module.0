Received: from sonic303-9.consmr.mail.bf2.yahoo.com (sonic303-9.consmr.mail.bf2.yahoo.com [74.6.131.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561735A513E
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907700; cv=none; b=QfhIJQciDwlFMw5XXz7f42pOp2DprT3tu9h1P0Xbk3Ls4T7cTzaSWEJPhn8OacPClUNGIHYGEkeqr8THPnEylLinl94LN2oig69D310r6RhBEs5xDE2vrN0dQlvMSD4D1psI48zBUTAk20vtjG9DCjmVEWec7hY/KZYEpMpHYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907700; c=relaxed/simple;
	bh=4aMvBaJfE6F6X8XAozVCxG84SSG/m3fXQl1EgHroo+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OB/XI5Dpcsw4D7fUBX2WSLDGWMv8viF7CWq+utcVgdWvHFpusfQxGwY9NGxFZcrf365sY0VcWVG7PbZwjSDfCVyXG4NBJ/UGjihrJtq69KXHqA39Fc0tCCr0i/+K7cyT/S81KLgWLyzH/pV8hLizv4PTVNAz8pWIftz3/Obq4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hv0/xfnY; arc=none smtp.client-ip=74.6.131.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hv0/xfnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788907689; bh=bNavbKXoeelFxomRONrX7NRcXGbrLs2sTeCQZ/9x9WE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hv0/xfnYQsXbNhgWZIbKxMsjumo24YzAvf366xw0MsJBNGE5hl4qIn4CTFbKWCFxwTccSpWgc3OgjFa3QXmFuRf8bYM6gDZDDQurLw1/HTWCoXRucmPSPRMpYF8oj5V4BG8kO9NXnxCOCEihChACZF76S5uPI426S8qzN0x0VV8epohpHFs8ZU8I0j05mYOG2G+/6DDUUHAdqcIP8nxSpddubPjbbfjmpaXrsM9d7kpZNBkPkLfIZDSAzFttm75gc9Mz7wWacEgGvCH7AH4/u9twiBLZ3vvhdpV6OLJyHrX8UUywreRePUJ1FZd71/5lSTbFarVjO/dcn7esapsVcg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788907689; bh=sLV57EjuzLEUcMB85He+Rh3eZ0NAFmSInP3vAj4kHRg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TUZanzLqllZtVx6RFC0ucez54dI9cWFiXp1zRSoBHsbkte4D9p9IvQl52X2NRr3RVVz9oRdksvJgAZtmzeZ6DG8tbC4EKtd6C2tn3g5e71bnN+H8RXFQJQAdDpMULFHHM9l4Y0PepdxbBAswnJgOB/y5a9eFqgqWemnunpyFkXEujjuV61kNz0HCpUINJe0qhNOmcz0DZhu4sUgUjg3/ezBBDqPBV/ULEZHgcn11+Jwwq0ZYIRGjxU5nxqvgOePpmU6+2f1KvKZpFaSLJ6j+e29Aji4tLXr2PY5hNmd2NXzumNGKRo6LNaK63soOrN990qJayxd30G4EEOOJ9tooDA==
X-YMail-OSG: TrdP450VM1nkRNToY09DfpMIhr9rz4ZnjyFwZiIWDsi6czussYfvBXPNU3RSC0l
 6OoozMRFSBbPH9xQE.rSHnJDkPKE.nNesm9FSmMAkbv4I6xZd2ZR8y_8R.ZXvVxlQzM7gYhYMild
 f2ajo9bgl9JIZfLSlAigtDBSeAg_Y6jg3ruKQOGor8hrqleMy2vCx7I2zOl.OewgxsADHTkiDZdw
 FkcEssdhqyrocYIgPCQVOp94.WihT53IR9LJR9wS00eCpougYJZna.dSV5Tgt5y6iwL_0fqjwWS8
 lw_vfBFO2z_tEfCc2i9sNGTMJe9NowvmEA8Xf.7BdANFQbqvRKxzbq_ezoxR2Lv0TiJGsH6pLhWl
 a3Sq5vOueupsZ260PXc26LOlcuyho5w3I6a16.ZnP1_6wsTObuBr97jCaH0jfSeg.wo.UAO7eINE
 PtxH3JqBy3lk3XCJ9aIBDmBUvzHWSXhA8wKZrexZtidjib4oRoB4PJwDpMKYOiZeBNyXfy3pOhlW
 PLISeRcv6uLT0Yh6zlKSUmiSFIk4vIN78XMSjQhl6ncQYVtAzX0tEDYXfd6ExxMb9n.p0kTWpCTy
 uAx_WFx33DC944kh2qndd63WVvE6_QTZhchaOUsqoGD8RmorhJhohVkdi.rj2R4KXO.5wiQW8Qrm
 6HhMTZe2BiK0dlnM5YFzO8Bg_6k3TMaNBLEKplGXj.BlvqyczivX64RXVdL5yQgmeNFzkcHy09p.
 Saw.FEziugfOA8KHv4kQjPu6zlmCstnD68d7AmZtfi857P13BNxiRMoTVhdtyNlj4z7O2MLd0J3w
 SWpTxLbmZEMIC8iY6nGdv3DNpttbJqIdaxbrN4W3y8.tCg.hJx6X9iUzLyBkKpbGW7N4dpNNI72i
 I6pWyrCypE119R3h0h1Mt4dMU.TUwE7xjyJ3nAqYqURHIgaywDMmMH0VSX3f5KGDMrAj3l06_4xC
 SWeWZc2_N.LS2rmyC04OungQoL1t6IEe9rHxaOkAjpIWeD7MqsacuqQr8Go365qzIf3hzxwQv45P
 xVgxT3_WKgVYoMG3CyLHNnJhEEWP.A39kIIc1p8V6QSMD5AJAdDuTM2hkVqVvfit8U1bP1MayHLE
 qHbb5NbJqHdMzsibLX9783gSlo_N_NDY2MUjrCUCFkHRHw8wF49UUNbm5mp_.m.vLFl1qBS8zh4v
 nmwH5mrZFxuH.DnuNbseFnQyowewr0CmwoEBRlkLqoO.RXj6iUivyDTa.aQpyrkPU9WArEZG27.L
 i6mupOsSFs8zuarMZW0wmLFtB7cGf3VXqNzvqgrSHOVXRRe92RTZUtL.R3I788ycIf45kQQnN3f8
 Sa4NsyJUXD7GBz1YiHvPsBVoPYkAocsZFNsbE.HDUkJhC43o7v1WkAP6ag6.MMkzBmD0as1qxEaI
 TxKHjRXE7AzNJ14lgGKXafqM7UCpp1tOrTBVUbnfYGpv5JHFhVAsg2jO038I6HLfr5xuni0V67DK
 w3OPjZX8F2EK8hJZ0ebOmfOefTFOzwePd42eAA76.sr9X88bPcSHZS7WcE4.s.lyIckQ6STBNI2O
 6AxrUPAiztRRrWsU39dTl.WXeqZBPnoNc9ub6FKc3.7AyHEhCoa3E_5kz3KwZIlOQ8uAgQIlDakp
 Inbigzv5YUT02wUl2OAv71QkSTT255zC0svgMKeDba3vfUA_eUU3SXfvZelPsjlJM6TXtmG.kYyK
 wWm_kRz58g_Eech1vxHGQvcgHrZxjDUC.aJ2oBP2MFhE3lpsWNU76jnr89xaDOi6ceyW9hVMcLAo
 ghUAlyUHKbj9daEjqNwGxTk3S6S.qaa.dMBhJlBGimbvYW_6qrmby0ohlb.k2DjFwyBNvEAnqjhU
 8RiUV60AkEiclpSEDmmUSzdGAMU7aO2jiRVP2Jrwe6mDVd5LaeNcKG7W9qBZ5m35bfwmylJneyTY
 vhlgzLU.B17nh4sd8psiU8rmR5BdJQ3e8hRcZb6d38LHKky5eI2aIKCB0RjJ.0x526_0TpjjdTLX
 NK94FppxMT9BRv9iDdKQyx7mHCMI9tJzl4K1hEbDjbrUMWqayBx.n3ITKi3N0.zLkfhSvOUYNQx8
 jVe9yde96vrIWsdbyLAzkFPSTl1.9G0BapK38mvHojMxA6rs8dAiQwpa5tz.ArHqg8BqgGvP37pH
 s_h6pqQQuk8UeiQaEkpVykys0pMKS46aPQOovOyWpVRUCXWZHIQlezhhytR3.JIEbzKCQebSPy_H
 D1E9meija16iTkt6DqY5ZQQ3NXHL13aGRhN2zCHEWJ5oZFMvqu7nTkkwwCmobfTE_sky_ofpFZZA
 BabnJDJcoOw6rPH2zxkY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c69521be-aa4e-43e0-980b-a309878f083c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 8 Sep 2026 22:48:09 +0000
Received: by hermes--production-gq1-678d9dd684-pmtnp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d02b3757abb6ec718247a44806490ae3;
          Tue, 08 Sep 2026 22:27:27 +0000 (UTC)
Message-ID: <312cbf15-71d7-4fac-bee4-67fd237c5f5b@schaufler-ca.com>
Date: Tue, 8 Sep 2026 15:27:25 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Paul Moore <paul@paul-moore.com>, daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
 <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26460 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/8/2026 3:05 PM, Paul Moore wrote:
> On Fri, Sep 4, 2026 at 10:48 AM Daan De Meyer via B4 Relay
> <devnull+daan.amutable.com@kernel.org> wrote:
>> From: Daan De Meyer <daan@amutable.com>
>>
>> Pass the mount idmap through the create, link, symlink, mkdir, mknod,
>> and permission hooks. Update the in-tree security implementations and
>> non-VFS callers accordingly.
>>
>> Signed-off-by: Daan De Meyer <daan@amutable.com>
>> ---
>>  fs/cachefiles/security.c      |  4 +--
>>  fs/namei.c                    | 18 +++++++-------
>>  include/linux/lsm_hook_defs.h | 23 +++++++++--------
>>  include/linux/security.h      | 58 +++++++++++++++++++++++++------------------
>>  security/security.c           | 40 +++++++++++++++++------------
>>  security/selinux/hooks.c      | 19 +++++++++-----
>>  security/smack/smack_lsm.c    |  9 ++++---
>>  7 files changed, 100 insertions(+), 71 deletions(-)
> Casey, are you okay with the Smack changes (below)?

Yes, assuming the 80 character limit is adhered to.

>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 8e88ac65fd7f..a45819d13c0d 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -1089,14 +1089,15 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>
>>  /**
>>   * smack_inode_link - Smack check on link
>> + * @idmap: idmap of the mount
>>   * @old_dentry: the existing object
>>   * @dir: unused
>>   * @new_dentry: the new object
>>   *
>>   * Returns 0 if access is permitted, an error code otherwise
>>   */
>> -static int smack_inode_link(struct dentry *old_dentry, struct inode *dir,
>> -                           struct dentry *new_dentry)
>> +static int smack_inode_link(struct mnt_idmap *idmap, struct dentry *old_dentry,
>> +                           struct inode *dir, struct dentry *new_dentry)
>>  {
>>         struct smack_known *isp;
>>         struct smk_audit_info ad;
>> @@ -1226,6 +1227,7 @@ static int smack_inode_rename(struct inode *old_inode,
>>
>>  /**
>>   * smack_inode_permission - Smack version of permission()
>> + * @idmap: idmap of the mount
>>   * @inode: the inode in question
>>   * @mask: the access requested
>>   *
>> @@ -1233,7 +1235,8 @@ static int smack_inode_rename(struct inode *old_inode,
>>   *
>>   * Returns 0 if access is permitted, an error code otherwise
>>   */
>> -static int smack_inode_permission(struct inode *inode, int mask)
>> +static int smack_inode_permission(struct mnt_idmap *idmap, struct inode *inode,
>> +                                 int mask)
>>  {
>>         struct superblock_smack *sbsp = smack_superblock(inode->i_sb);
>>         struct smk_audit_info ad;
>>
>> --
>> 2.54.0
