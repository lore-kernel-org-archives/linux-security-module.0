From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Tue, 11 Jul 2017 12:33:42 -0400
Subject: [PATCH] ima: namespacing IMA (PoC) - experimental 
Message-ID: <D984A9E8-34DA-4A96-A134-5F87241F08E8@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This IMA namespacing patch set was initially implemented by Yuqiong Sun, 
while at IBM Research as a summer intern working with David Safford. It 
was subsequently modified and rebased by Stefan Berger and Mehmet 
Kayaalp. The resulting patches are being made available from the 
"next-namespacing-experimental" branch on 
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
as a proof of concept, but will not be upstreamed.

Namespacing IMA is complex. It involves differentiating the IMA global 
information (e.g. file hashes) from the IMA namespace specific 
information (e.g. collected, measured, appraised). This information 
needs to be created, updated, and freed as namespaces come and go, and 
also freed when files are removed from the file system. In addition, 
namespacing IMA properly also requires namespacing the securityfs files 
(eg. policy, ascii/binary measurement lists), keyrings needed for 
validating file signatures, and the hash table used to prevent the same 
file from being measured multiple times within the same namespace, yet 
separately in each namespace.

This requires some form of capability/permission checking. Currently, 
only root with CAP_SYS_ADMIN permission is able to write securityfs 
files and security xattrs. In addition, the IMA security xattrs need to 
be namespace aware. (Other LSM subsystems are making similar changes.)

Like other initial subsystem namespacing, this IMA namespacing patch set 
defines a new IMA namespace that is created with a new clone flag (this 
needs to be changed). An unprivileged user can create an IMA namespace 
in a new user namespace. The IMA securityfs policy file can be read and 
set by a user with CAP_SYS_ADMIN within the user namespace, where the 
IMA namespace is created. The policy can define the namespace 
measurement and appraisal rules. Measurement is done recursively for 
each nested IMA namespace. If the file to be measured is in policy for 
multiple IMA namespaces, it is measured for each namespace. The list of 
measurements are available to the CAP_SYS_ADMIN under the owner user 
namespace. For appraisal, the non-init IMA namespaces use the "_ima" 
session keyring. If the keyring is created and populated with keys, 
these keys will be used for the appraisal rules defined in the policy of 
the IMA namespace. Attestation for the IMA namespace is not supported in 
this patchset.

For testing, we modified "runc" to create an IMA namespace and 
initialized the policy and the keyring inside the container between the 
clone() and exec() system calls. For accessing the IMA files in 
securityfs inside the container, CAP_SYS_ADMIN is required to be added 
to the list of capabilities in the config.json file. "runc" tries 
loading the policy from /etc/default/ima-policy, and keys from 
/etc/keys/ima/ inside the rootfs of the container. The runc patches are 
available at the "imans" branch on https://github.com/stefanberger/runc.

Major changes include:
* Keyring creation is moved to userspace.
* Policy file is changed back from procfs to securityfs. 
* Temporarily the IMA files are only accessible to CAP_SYS_ADMIN with 
permissions set to user, group, and other.
* Patches should now be bisect-safe.

Regards,
Mehmet

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
