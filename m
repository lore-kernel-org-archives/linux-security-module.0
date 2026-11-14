Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680096;
	b=rl7xR51fGbskdtjlpt7VuOR988Wfu45Q4fcoghFIywJx6GxJDfnC6G7mM2pvLFVqs3Vp
	 U3P8P5D25nlw9bXBwBJH3vu0J12E6UBvrKIHLdLoUVAlcgXpJB58cO88vzWAzVpwR/AZV
	 OERDmmJ+O0iLzxMvG++xEyeHlW7EdiEE6Hj3nTnBuFEQSeCOkzRzXiZN9PNCvDiu3arpQ
	 FMZWC7plURotkj7TqQzEQcuAgJ4ak+OOTIlE408fIN2YkEAFnzCLWEPv9PEx7Hla6ukUO
	 aw+umJ7w0Er5G6IgX4QdMK3kenhYkBURRCnQvEfXreXjMOSySNKqQTsTEbdwThPX8OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680096;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=BleYk407yT9mH7kAH7nAMJTsO4RLTrDZOb9d/32h1tE=;
	b=j82a+qOEPczxh6f7PCJdeaKPHv2X5O4sGn+NaNxcWnR78Hgcs4SAC/wJcxVZTys3Mxz4
	 pEi4aKeJa7q7/u+TIrh798lV0WtmFF9agndU9+YSZepdA93emKcdxr56fkw67+Y+NRq6r
	 TG4YIvC1hxUs0FZnh+SBeAOehHUWiogN8Vwmlnmhx4lXpZ25xfK0cXY8Qc2nCx6NHvrpc
	 qTnClRsZu1CrllilBXE8LWKZ7PsfUg8tjTi310/UCccTgTnJElKpyFgeJ2ngCZwhIWbRZ
	 iPj9Au/AVVTcKc3a3S4O/bQd66aGz92PmHhC037ls5LoG+0rap5hargORKlzmkkQBsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=NIfahSOe;
	arc=none smtp.remote-ip=66.163.184.207
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090AF606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 18:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 090AF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=NIfahSOe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794680095; bh=BleYk407yT9mH7kAH7nAMJTsO4RLTrDZOb9d/32h1tE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=NIfahSOeSP4llq4FDwqsWp7toBqK+uLIN+4XdTnK5YvFZKGfS2khmPygy+ALsjWyO3C4/FZGtqGy7SYEAeoUC2vhyOvGhpLnbbprNd6SiStKpk45n7mVSE5UO62kcHcnW0aaWwAjs7+F3M3ncNnVdtY7XXcu0Jt2lr14r2SmwokPT5izVqgaCO7g9aXsgzaAs4q8Z9oKoby4EI5r6y/NrUtfTmy6BmsFczOFk/QaokmnqugE9mvd22TtR+U8FgibbEYOgaIEOgT7eqMAE6OlIymrbH3hguZnidd2lvS1obBFPeVTLLQzDHxkVH0LY0iWpuA9Yk1KD//6+baPR1Yn+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794680095; bh=mOIFE8fX/Gl137wkql/ygLaP/xBkJLcSPKXEuc9rl8h=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PIznIOLXqv5+vuvIT9e5jp7WkNumn8N9u5uSxLnGOqKYUlxpGUJ88cAMgvK8Hd6imt8NIDLBq18MyrgsQg2A2sKkvY4Ji6PRFfD1M2tSWgc8w5On+b0Z1NnIE9HWUwSxzdo+KyhlVCta+GxJpJPdts4jogCnGIYtLt2YapPHrsTmQ/O2w6fTbJhXpKhR1MchOnp0LibO55VtV4BFcb7Ncz7aXA1HHD+k3+3emUBF8AqQM4jyaC/jV0N5V3XujxNdlC9h2ieQKQNUpSj5ErAM9pQrKwM/junBiQ2qnSY8cL4/Y4cvi1aXV6A0wYeuO4sLs9sRf1jxJm8Cg6fS2IWidQ==
X-YMail-OSG: YE7jjKAVM1nOAp.RVJwdTtj8.3XQMUJjefbPhiV4FP5SdLjDqAR2iJHN_kUY2s5
 6veYkZ83WZ_OtTAwAM.2LLQO47t7WhsQREIYOCcXG42SCvraxZGkoLYyHABRWlya5NWFMwSs25X1
 bdKiO3mRySWW4BH7sryxWRTMRVpv2tylfjtNA6KIA7_bgjxjYkLiORpWTJa2mWcHkfcodz947EmG
 zmvMUA9t34X.3pyDriRCr_i6O6HAOrV_Z1aIzoJG4Zjr_N9Vd7sOynwEVqByEyK7Vl5hwuiXosmR
 d.cu22r2YDCihuu.EPj1ZCKuzYqht9Dn28AbXgrBdjmQRJUt7OgnIbzvZKh3tL8IvnM.qU5rWbCy
 aI0bZek21VChUo3wEmVwY6gt1O1XsNC.zgQMXYkpMwkOf.Jl3Jdo3wHu2R.01WtxxcIhqH4A3VI.
 PZoPKroROEbuEub8iyNqJsSPB5WIA99JoyOCdvlsZooS5xdPV8mAscffAYKxKsYXgRCRe1J1fIaz
 .1SPP.h7CIgRU0qmHfgzlrDuQjncWiEbOcK2rN9NdeiN7jDtJwBBbriSvgbmDF3WOEksmEy1TKe6
 5IbMiO4BQOgFqFkwRaE91L5AH3qbrrUlPWbxfrccx0X4HeNj_OPPHVxXFOtFZC1CjSlydzFBrH4q
 _OF8tp6WGXOFCvAoc5DuWgJfG77Io9T7gvyK1hoCam91nzsOM2KYDKcD.3srNgpm.dMrNjzkBQxn
 85M75vg4bJ8HYx9VabF9FabIpUmRxEzJeQSTb.z2gVAhYGHvz7YjJfqFabTICVSxnTo9uoInrxW3
 cScmTgj_8WOXFrIw.7VT.ZCvq5vNJ25.KPQqUfZ6uYADlvFsMUAn8PRPoPxuvmI5qx2PIr1dDlSg
 45TrIE_zkU9YyZrERqtgdynHztlbOnK36GmDA8wTE0qBco9xQ7TS9DVAJRXpQdHa5SSKUgdxub9m
 Xbdd5ZhhWYR6MM0zIjF3pnMCey1Xa9UmcFbzOy29v_pmVLEkyjfxO0QgY3y4hrIwSnV.TtmlKJ00
 6qmUeZ5rrdr6rNm3xcyvjdni0NqlFB1Ei3_cMvYWk_g7HdHhySSwKy9ccMlo6eIQ1F6z1zJbWjAx
 _rJ6ME2vEL9ABOfyxXDvbHnTUbAFyw5IPxSxPCo8Png0Y6xzpFX3k7U1e3QlAxdNUCw3IPRTeOJf
 bG8blKVniS77v248rHne6Fv5b_ul1.uI9smPAW3DOiTDm2OVFsEzNBI6rZ3zkuL356efZfbSIXKZ
 JHj8ZfJPyoKS4TU2ndmwOLQwZHtKWIM_x2N6TbXmW2gXSA6wYwngmehCo8DVgWkFEmI4wSth6h9b
 79JaGEQSuRSOmDgFw08LLjPH162COnlz1MNWdk7AyCQh_71PgseAkbLl3IdUiwsGjKL97fS3BUvm
 MxoYGZCGC7PXxInwO31.QwwHefqbH.jtVqMH8WM8LopHp5dR_V.tJD9w3uRpj5awq55pxAwxm.L4
 ARKRoBMKdBczNyTzvByFpe_pUUEJXBUKG16YjRPV5KcRYLYs.9Xsp_krgey1_9gVf5QKuzOKPkkk
 kB.4WfXA5p9hxPy6GrUif6eQSMi_HCUAq2IAMvnqvIwueQx6zn9BehppWe2j5ZiXe4rcsZyDrEzt
 Dch7j4J0McZbsJGq_L4I2ZJWXm6ljC9YMmwGzjrge8.nicJTfjAk8QtqqxY_a4ambjg8RQjOL9Dc
 8EzkZw4CVKzyY0Ea2Bcn5VIe3TTxkDB1UtUIsS3U06CtwPI1ehNAQZFecbYD5pNULkNHKU6fsZlr
 bVUmp._ZqtZYqW2EKb3WFFn0etATQYHgerTpV_eRtKTcHAKm4mzmfcECmSfGObPlf_UH.xllCx9.
 X714L_Rn_6WqkSR1U0ZbT9nMUP335C6B5uXjxssHiixfNPb6q65QyPHwa8PQp1MX6yZsvJsRUfGL
 plLoE4LlJQ88iCL65q9zgsD0L7CEXHHjfy0GXaKvcfUlwzS9X7oH20DMscbgWuDn5LufThMXMlKR
 9BmsraA7fwuPGfoSeoGSanyxg7_kMjXu1AaAwdfzH56qgwKP4VOfXzsrRuyQ7.LmnuCqseX9OGas
 y2bD8dWpMeTjGoGmEYevO_zEf8R4kPJIjnY54CVptnVgTQthgziEUstCpmmxcki1nZaPes4k3kFO
 Rvm_ZRwSDETICrVMaBmaG6HWMncQQuN6cuNNCCfQefzsmKWAxsNDLGZTzts7BU6OUnklhB0fzHYj
 pBsfA_0NZJUBCLXP.66c.8hhxxN69zZcPCdNW3_vYc0N2vmW9nxJMRav072zAHbWT8eOvUfGAGvq
 AlJOcf.lTolyRxiez0EKltmSHjA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6bbeab83-61d7-44aa-ba66-e13ae870518d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 14 Nov 2026 18:14:55 +0000
Received: by hermes--production-gq1-fd7994565-ftb5j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 93152b98dffd162510b663d2c83ea3b9;
          Sat, 14 Nov 2026 18:14:49 +0000 (UTC)
Message-ID: <58bb5c0e-6627-488f-a400-bf9cd5b60b22@schaufler-ca.com>
Date: Sat, 14 Nov 2026 10:14:46 -0800
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LSM: check if lsmprop_to_secctx call is supported by LSM
To: Tomasz Unger <tomasz.unger@yahoo.pl>,
 Sebastian Bockholt <sebastian.bockholt@bevuta.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com,
 serge@hallyn.com, jmorris@namei.org, audit@vger.kernel.org,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260619171945.1617498-1-sebastian.bockholt@mail.networkname.de>
 <20261111211722.69639-1-tomasz.unger@yahoo.pl>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20261111211722.69639-1-tomasz.unger@yahoo.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.27017 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/11/2026 1:17 PM, Tomasz Unger wrote:
> On Fri, 19 Jun 2026 19:19:45 +0200, Sebastian Bockholt wrote:
>> In include/linux/lsm_hook_defs.h, lsmprop_to_secctx is defined with
>> a default return value of -EOPNOTSUPP.
>> The function bpf_lsm_lsmprop_to_secctx, defined in
>> security/bpf/hooks.c, returns the hook's default value. Therefore,
>> directly returning the result of the bpf_lsm_lsmprop_to_secctx call
>> propagates an unchecked EOPNOTSUPP error.
> [...]
>
>> -		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
>> +		error = scall->hl->hook.lsmprop_to_secctx(prop, cp);
>> +		if (error == -EOPNOTSUPP)
>> +			continue;
>> +		return error;
> Hi,
>
> I ran into the same problem independently and would like to revive this
> patch. It fixes a regression that is still present in v7.4-rc2, in
> next-20261111 and in the current audit and lsm dev branches.

As currently implemented the LSM infrastructure supports only one
LSM providing conversions between the LSM security state (lsmprop or secid)
and the security context (secctx). I have been working on removing
this restriction for the past 16 years. It isn't done, and every time
someone tries to do something that expects otherwise it breaks. The
BPF LSM registers hooks that do nothing for (most) every case. That
only works if the BPF LSM is registered after any LSM that provides
real hooks. We've told y'all that many times.

If you really want the BPF LSM to stack properly you have options.
You can stop registering hooks that can't function properly in the
stack you want to use. You can help with getting the stacking complete.
You can continue to ask for individual tweeks each time they come up.

Maybe taking this change is the best we can hope for. My frustration
level is getting pretty high with the whole situation.

