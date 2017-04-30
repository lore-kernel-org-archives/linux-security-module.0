From: mic@digikod.net (=?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=)
Date: Sun, 30 Apr 2017 11:35:26 +0200
Subject: [PATCH v1] LSM: Enable multiple calls to security_add_hooks() for
	the same LSM
In-Reply-To: <201704301111.CFC52113.LFVFQJtFOOMHOS@I-love.SAKURA.ne.jp>
References: <20170429190257.27137-1-mic@digikod.net>
	<da65a5ff-62a3-f755-1e8c-bf91a03fd1c9@schaufler-ca.com>
	<201704301111.CFC52113.LFVFQJtFOOMHOS@I-love.SAKURA.ne.jp>
Message-ID: <46eeb13f-db7f-68c4-0bf7-fddaaed5460c@digikod.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On 30/04/2017 04:11, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 4/29/2017 12:02 PM, Mickael Salaun wrote:
>>> Check if the registering LSM already registered hooks just before. This
>>> enable to split hook declarations into multiple files without
>>> registering multiple time the same LSM name, starting from commit
>>> d69dece5f5b6 ("LSM: Add /sys/kernel/security/lsm").
>>
>> What's special about the previous registration? Keep it
>> simple and check it the name is already anywhere on the
>> list and only add it if it's not already there. I don't
>> see advantage to:
>>
>> 	% cat /sys/kernel/security/lsm
>> 	capability,yama,spiffy,selinux,spiffy
>>
>> over
>> 	% cat /sys/kernel/security/lsm
>> 	capability,yama,spiffy,selinux
>>

That was my first though, but then I realized that I don't see any use
case where an LSM would register hooks interleaved with other LSM. I
find the current approach simpler because we only search from the end of
the string and we do not handle special cases (e.g. matching only a
sub-name). Moreover, this approach respects the semantic describe in
Documentation/security/LSM.txt: "The list reflects the order in which
checks are made".

> 
> -	if (lsm_append(lsm, &lsm_names) < 0)
> +	if (lsm && lsm_append(lsm, &lsm_names) < 0)
> 
> in security_add_hooks()?
> 

That was considered
[https://lkml.kernel.org/r/CAGXu5jJCvJ6-uZ=Kfhh3xD7UvaY+G99e9NXFMzvi=9OQzA6Ecg at mail.gmail.com]
but Kees and Casey seem to prefer the current approach.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170430/f8158ef3/attachment.sig>
