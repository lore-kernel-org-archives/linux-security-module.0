From: mtownsend1973@gmail.com (Martin Townsend)
Date: Tue, 20 Mar 2018 15:01:01 +0000
Subject: Problem mounting pseudo filesystems with SMACK and IMA enabled.
In-Reply-To: <1521552744.22230.25.camel@linux.vnet.ibm.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
	<1521206743.3503.29.camel@linux.vnet.ibm.com>
	<CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
	<1521211762.3503.46.camel@linux.vnet.ibm.com>
	<77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
	<CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
	<CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
	<1521474460.3503.191.camel@linux.vnet.ibm.com>
	<CABatt_wfwRqJRie=eoaaXnfxd7EUBhDL-jPjPbBHbwcnpMWj7g@mail.gmail.com>
	<1521552744.22230.25.camel@linux.vnet.ibm.com>
Message-ID: <CABatt_yk+pgwxHVv+RY08xFDOfzxb4w6ELW7RxhW6gWQ=5Hvnw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 20, 2018 at 1:32 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-03-20 at 10:23 +0000, Martin Townsend wrote:
>> On Mon, Mar 19, 2018 at 3:47 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> > On Mon, 2018-03-19 at 14:37 +0000, Martin Townsend wrote:
>> > [...]
>> >> The problem was because systemd couldn't create directories for the
>> >> mounts /dev/shm and /sys/fs/cgroup/systemd, it was returning -ENOKEY.
>> >
>> > There's a disconnect between what ima-evm-utils supports and the
>> > kernel.  This sounds like the kernel you're using has directory
>> > support, which has not been upstreamed.
>> >
>> >> After investigating it looks like I need to set a key for HMAC to stop
>> >> the mkdir failing which I didn't appreciate I needed with a pre-signed
>> >> image.
>> >
>> >> I have a question on this, looking at the IMA code it will try and
>> >> replace my signatures with the HMAC unless the immutable attribute is
>> >> set, is this correct?
>> >
>> > EVM will replace the file signature with an HMAC, unless the
>> > filesystem is mounted r/o, is immutable, or is signed with the new EVM
>> > portable and immutable signature.
>> >
>> >>  In the evmctl utility there's mention of an evm
>> >> immutable flag but I see nothing in the kernel code that supports
>> >> this. Is this a feature that never made it into the kernel? or is it
>> >> there but I've missed it?
>> >
>> > The portable and immutable EVM signature is being added only in this
>> > release (linux-4.16).
>> >
>> >> Second question, I have no TPM module so do I need to add a key for
>> >> HMAC or is there another way? It's not a problem if I have to add a
>> >> key I just want to make 100% sure I have to before patching systemd or
>> >> creating my own init process that adds the key before handing over to
>> >> systemd.
>> >
>> > systemd already has support for loading an EVM key.
>> >
>> > The EVM encrypted key could be based on either a TPM trusted key or a
>> > user key, without the HW guarantees of the private key not being
>> > exposed in the clear.  If you don't need an EVM key, then without a
>> > TPM, you're probably better off backporting the new portable and
>> > immutable EVM key.
>>
>> I've taken a look at the kernel patch "EVM: Add support for portable
>> signature format" and this looks like the exact feature I've been
>> looking for :) and it applied fairly cleanly to 4.9 with just a couple
>> of easy manual edits.
>>
>> I upgraded to the latest 1.1 ima-evm-utils on my host system but I
>> can't sign any files with the --portable flag.  (I've added the
>> function failing to the log_err function)
>>
>> $ LD_LIBRARY_PATH=build/src/.libs sudo ./build/src/.libs/evmctl sign
>> --imasig -v -o --generation 0 --uuid  --key
>
> Can you try signing the file without "--generation 0 --uuid"?  Please
> provide the output of "getfattr -m ^security -e hex --dump
> <filename>".  The security.evm portable and immutable signature should
> begin with 0x05.
>
I get the following
LD_LIBRARY_PATH=build/src/.libs sudo ./build/src/.libs/evmctl sign
--imasig -o --key
/ws/rufilla/curtisswright/cwr-signing-authority/ca/ima/inter/private/ima-privkey.pem
/mnt/ubi/usr/bin/nsenter
ioctl() failed
errno: Inappropriate ioctl for device (25)

You can see in the hexdump from my previous post below it tries to
send a signature with 05 at the start.

Reverting back to 1.0 ima-evm-utils and hacking the kernel to add the
EVM key it booted but I couldn't add SMACK rules in fact I couldn't do
anything with smackfs and after further debugging it was because
IMA/EVM was measuring and appraising everything in /sys/fs/smack
With the following patch I have finally got SMACK and IMA working together:

>From 3eaa37f3b1848943b2ab9e07f595e0d6e8aba1c5 Mon Sep 17 00:00:00 2001
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Tue, 20 Mar 2018 12:14:57 +0000
Subject: [PATCH] Ensure we don't meausre or appraise SMACKFS by default

---
 security/integrity/ima/ima_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c
b/security/integrity/ima/ima_policy.c
index aed47b7..678d0d7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -92,6 +92,7 @@ static struct ima_rule_entry dont_measure_rules[] = {
  {.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_MEASURE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
+ {.action = DONT_MEASURE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_MEASURE, .fsmagic = CGROUP_SUPER_MAGIC,
  .flags = IMA_FSMAGIC},
  {.action = DONT_MEASURE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC}
@@ -132,6 +133,7 @@ static struct ima_rule_entry default_appraise_rules[] = {
  {.action = DONT_APPRAISE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_APPRAISE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
+ {.action = DONT_APPRAISE, .fsmagic = SMACK_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
  {.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags =
IMA_FSMAGIC},
 #ifdef CONFIG_IMA_WRITE_POLICY
-- 
2.7.4

Not sure why SMACK is not already there, do you want me to submit this
patch formally or is there a good reason for the omission?

> Mimi
>
>
>> /ws/rufilla/curtisswright/cwr-signing-authority/ca/ima/inter/private/ima-privkey.pem
>> /mnt/ubi/usr/bin/nsenter
>> hash: ccb3b93abd61cd1403ce00adbdbc1a75f2d5e9fb
>> evm/ima signature: 264 bytes
>> 030202a35fd9c60100843c31d91371b691064de4d4f3961d79d5810e24198e18d3b625e75ce8e51cf6a4e45e2fe0e11ab42ac03567952367303d863d978338472fb1689c90fd69524527750e8a0fe39a586f9d24790a45367f2354e9f5bb855e7543f408f4765195ee8d9b81d9bbc4bfed9b5ab16bb8e7a50a45316969c5074c2a213166cbdbc20006b3bb7d721071afdd10cfd9b10e392d8896f67ca3c8391c418515bb3fbfa5c1e0b811a58f394c29be4b73f01804796edee3c84e5fc82e87af1b0a13218de3f2c1e0b328d030291eaab53edd9ffee7ed3febe7e12e4bd26fe36851f095908b03e990548f8759e336987198a55919c7f4333b63630038236fc29df2960d1be1a94a
>> generation: 0
>> no xattr: security.selinux
>> no xattr: security.SMACK64
>> name: security.ima, size: 265
>> no xattr: security.capability
>> sign_evm: calc_evm_hash returned 20
>> hash: ad2747d58d06fe7ecf3fea272b68c058c4298941
>> evm/ima signature: 264 bytes
>> sign_evm: sign_hash returned 264
>> 050202a35fd9c601009226f3cba14c00890ea24c0f6bb28176a6e3a7ecadd53a20b7314844c68147e2e8f0d23c15852f88ecb77711518db2431a656434ed9db108ec586ebd1b1343bf1d526e1bb55aab1b9c00cd30619965dc61aae5b9482f6b8bd511cfa098550bc1e65a8541d86ea2f3f01f247dfb219274ab926d905d2bb691e308357e03e8308d3b33e6c0a5f14502a2047679379fce1457529d06665d147cf528b1dd762540574274035d5130f50cc2c14b6a323f4022ce5cbff074230fe8ee81a8b8fad97edec0eae221c6db5272430cf00373c9d50772830729f9eb4473cfb10e7f640daa097a71635548c77f0a96ab91e8c1c0e7b2bfb55588a5fb82a8454f89d7922d96bf
>> sign_evm: setxattr security.evm failed: /mnt/ubi/usr/bin/nsenter
>> : errno: Operation not permitted (1)
>> errno: Operation not permitted (1)
>>
>>
>> Yet without --portable it signs the file fine.
>>
>> $ LD_LIBRARY_PATH=build/src/.libs sudo ./build/src/.libs/evmctl sign
>> --imasig -v --generation 0 --uuid  --key
>> /ws/rufilla/curtisswright/cwr-signing-authority/ca/ima/inter/private/ima-privkey.pem
>> /mnt/ubi/usr/bin/nsenter
>> hash: ccb3b93abd61cd1403ce00adbdbc1a75f2d5e9fb
>> evm/ima signature: 264 bytes
>> 030202a35fd9c60100843c31d91371b691064de4d4f3961d79d5810e24198e18d3b625e75ce8e51cf6a4e45e2fe0e11ab42ac03567952367303d863d978338472fb1689c90fd69524527750e8a0fe39a586f9d24790a45367f2354e9f5bb855e7543f408f4765195ee8d9b81d9bbc4bfed9b5ab16bb8e7a50a45316969c5074c2a213166cbdbc20006b3bb7d721071afdd10cfd9b10e392d8896f67ca3c8391c418515bb3fbfa5c1e0b811a58f394c29be4b73f01804796edee3c84e5fc82e87af1b0a13218de3f2c1e0b328d030291eaab53edd9ffee7ed3febe7e12e4bd26fe36851f095908b03e990548f8759e336987198a55919c7f4333b63630038236fc29df2960d1be1a94a
>> generation: 0
>> no xattr: security.selinux
>> no xattr: security.SMACK64
>> name: security.ima, size: 265
>> no xattr: security.capability
>> sign_evm: calc_evm_hash returned 20
>> hash: d1f22a34a86efc9f15345a39dae2e0c169373d75
>> evm/ima signature: 264 bytes
>> sign_evm: sign_hash returned 264
>> 030202a35fd9c6010001e61de529c455a357de9502fd2d509535dcc43fc42138f27cdcd49d82374dee85504de52599bfb9745a7ec6ad8de49a45bc5691ba8a23d5c0505b247a0397a297b7bc21e9be8b883c2fab86df602b8445fa3d29b7441b5c1de340bf5ee047af0737f707d8228517171eb99d290b9d0aeb1577badb9d2cc44b2b2963ebebb57da4e2b37ce735d7adc9ae82497c9883abcb3b8b5a1a690aaae148e347fbd12cf08e6168868d6588a57523235009ab8ef199627cadbb80eb8fb24dfcb941c28dbe54b80a036dd4c0d2b3d40d4d8ca9c1821e90400e1202ad32343304a80bcd37f5a2616c3790cb6d86ecb0431adf73100a3a163b8fed625711ca10df8ca429d9cf
>>
>>
>> I've tried removing various parameters from evmctl but it still fails.
>> The only difference I can see in the code path is
>> if (evm_portable)
>>     sig[0] = EVM_XATTR_PORTABLE_DIGSIG;
>> else
>>     sig[0] = EVM_IMA_XATTR_DIGSIG;
>>
>> before calling lsetxattr, so I followed lsetxattr in the kernel and I
>> think it's going to end up at security_inode_setxattr in security.c
>> which will then call evm_inode_setxattr which is going to fail on my
>> Host PC (Ubuntu 16.04 with a 4.13 kernel ) as it doesn't support this
>> new xattr data type:
>>
>> if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
>>     return -EPERM;
>>
>> Does this sound about right?
>>
>> Many Thanks, Martin.
>> >
>> > Mimi
>> >
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
