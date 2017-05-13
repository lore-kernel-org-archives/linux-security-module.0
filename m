From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:49 -0700
Subject: [PATCH 13/17] doc: ReSTify Smack.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-14-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adjusts for ReST markup and moves under LSM admin guide.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../Smack.txt => admin-guide/LSM/Smack.rst}        | 273 ++++++++++++++-------
 Documentation/admin-guide/LSM/index.rst            |   1 +
 Documentation/security/00-INDEX                    |   2 -
 MAINTAINERS                                        |   2 +-
 4 files changed, 191 insertions(+), 87 deletions(-)
 rename Documentation/{security/Smack.txt => admin-guide/LSM/Smack.rst} (85%)

diff --git a/Documentation/security/Smack.txt b/Documentation/admin-guide/LSM/Smack.rst
similarity index 85%
rename from Documentation/security/Smack.txt
rename to Documentation/admin-guide/LSM/Smack.rst
index 945cc633d883..6a5826a13aea 100644
--- a/Documentation/security/Smack.txt
+++ b/Documentation/admin-guide/LSM/Smack.rst
@@ -1,3 +1,6 @@
+=====
+Smack
+=====
 
 
     "Good for you, you've decided to clean the elevator!"
@@ -14,6 +17,7 @@ available to determine which is best suited to the problem
 at hand.
 
 Smack consists of three major components:
+
     - The kernel
     - Basic utilities, which are helpful but not required
     - Configuration data
@@ -39,16 +43,24 @@ The current git repository for Smack user space is:
 This should make and install on most modern distributions.
 There are five commands included in smackutil:
 
-chsmack    - display or set Smack extended attribute values
-smackctl   - load the Smack access rules
-smackaccess - report if a process with one label has access
-              to an object with another
+chsmack:
+	display or set Smack extended attribute values
+
+smackctl:
+	load the Smack access rules
+
+smackaccess:
+	report if a process with one label has access
+	to an object with another
 
 These two commands are obsolete with the introduction of
 the smackfs/load2 and smackfs/cipso2 interfaces.
 
-smackload  - properly formats data for writing to smackfs/load
-smackcipso - properly formats data for writing to smackfs/cipso
+smackload:
+	properly formats data for writing to smackfs/load
+
+smackcipso:
+	properly formats data for writing to smackfs/cipso
 
 In keeping with the intent of Smack, configuration data is
 minimal and not strictly required. The most important
@@ -56,15 +68,15 @@ configuration step is mounting the smackfs pseudo filesystem.
 If smackutil is installed the startup script will take care
 of this, but it can be manually as well.
 
-Add this line to /etc/fstab:
+Add this line to ``/etc/fstab``::
 
     smackfs /sys/fs/smackfs smackfs defaults 0 0
 
-The /sys/fs/smackfs directory is created by the kernel.
+The ``/sys/fs/smackfs`` directory is created by the kernel.
 
 Smack uses extended attributes (xattrs) to store labels on filesystem
 objects. The attributes are stored in the extended attribute security
-name space. A process must have CAP_MAC_ADMIN to change any of these
+name space. A process must have ``CAP_MAC_ADMIN`` to change any of these
 attributes.
 
 The extended attributes that Smack uses are:
@@ -73,14 +85,17 @@ SMACK64
 	Used to make access control decisions. In almost all cases
 	the label given to a new filesystem object will be the label
 	of the process that created it.
+
 SMACK64EXEC
 	The Smack label of a process that execs a program file with
 	this attribute set will run with this attribute's value.
+
 SMACK64MMAP
 	Don't allow the file to be mmapped by a process whose Smack
 	label does not allow all of the access permitted to a process
 	with the label contained in this attribute. This is a very
 	specific use case for shared libraries.
+
 SMACK64TRANSMUTE
 	Can only have the value "TRUE". If this attribute is present
 	on a directory when an object is created in the directory and
@@ -89,27 +104,29 @@ SMACK64TRANSMUTE
 	gets the label of the directory instead of the label of the
 	creating process. If the object being created is a directory
 	the SMACK64TRANSMUTE attribute is set as well.
+
 SMACK64IPIN
 	This attribute is only available on file descriptors for sockets.
 	Use the Smack label in this attribute for access control
 	decisions on packets being delivered to this socket.
+
 SMACK64IPOUT
 	This attribute is only available on file descriptors for sockets.
 	Use the Smack label in this attribute for access control
 	decisions on packets coming from this socket.
 
-There are multiple ways to set a Smack label on a file:
+There are multiple ways to set a Smack label on a file::
 
     # attr -S -s SMACK64 -V "value" path
     # chsmack -a value path
 
 A process can see the Smack label it is running with by
-reading /proc/self/attr/current. A process with CAP_MAC_ADMIN
+reading ``/proc/self/attr/current``. A process with ``CAP_MAC_ADMIN``
 can set the process Smack by writing there.
 
 Most Smack configuration is accomplished by writing to files
 in the smackfs filesystem. This pseudo-filesystem is mounted
-on /sys/fs/smackfs.
+on ``/sys/fs/smackfs``.
 
 access
 	Provided for backward compatibility. The access2 interface
@@ -120,6 +137,7 @@ access
 	this file. The next read will indicate whether the access
 	would be permitted. The text will be either "1" indicating
 	access, or "0" indicating denial.
+
 access2
 	This interface reports whether a subject with the specified
 	Smack label has a particular access to an object with a
@@ -127,13 +145,17 @@ access2
 	this file. The next read will indicate whether the access
 	would be permitted. The text will be either "1" indicating
 	access, or "0" indicating denial.
+
 ambient
 	This contains the Smack label applied to unlabeled network
 	packets.
+
 change-rule
 	This interface allows modification of existing access control rules.
-	The format accepted on write is:
+	The format accepted on write is::
+
 		"%s %s %s %s"
+
 	where the first string is the subject label, the second the
 	object label, the third the access to allow and the fourth the
 	access to deny. The access strings may contain only the characters
@@ -141,47 +163,63 @@ change-rule
 	modified by enabling the permissions in the third string and disabling
 	those in the fourth string. If there is no such rule it will be
 	created using the access specified in the third and the fourth strings.
+
 cipso
 	Provided for backward compatibility. The cipso2 interface
 	is preferred and should be used instead.
 	This interface allows a specific CIPSO header to be assigned
-	to a Smack label. The format accepted on write is:
+	to a Smack label. The format accepted on write is::
+
 		"%24s%4d%4d"["%4d"]...
+
 	The first string is a fixed Smack label. The first number is
 	the level to use. The second number is the number of categories.
-	The following numbers are the categories.
-	"level-3-cats-5-19          3   2   5  19"
+	The following numbers are the categories::
+
+		"level-3-cats-5-19          3   2   5  19"
+
 cipso2
 	This interface allows a specific CIPSO header to be assigned
-	to a Smack label. The format accepted on write is:
-	"%s%4d%4d"["%4d"]...
+	to a Smack label. The format accepted on write is::
+
+		"%s%4d%4d"["%4d"]...
+
 	The first string is a long Smack label. The first number is
 	the level to use. The second number is the number of categories.
-	The following numbers are the categories.
-	"level-3-cats-5-19   3   2   5  19"
+	The following numbers are the categories::
+
+		"level-3-cats-5-19   3   2   5  19"
+
 direct
 	This contains the CIPSO level used for Smack direct label
 	representation in network packets.
+
 doi
 	This contains the CIPSO domain of interpretation used in
 	network packets.
+
 ipv6host
 	This interface allows specific IPv6 internet addresses to be
 	treated as single label hosts. Packets are sent to single
 	label hosts only from processes that have Smack write access
 	to the host label. All packets received from single label hosts
-	are given the specified label. The format accepted on write is:
+	are given the specified label. The format accepted on write is::
+
 		"%h:%h:%h:%h:%h:%h:%h:%h label" or
 		"%h:%h:%h:%h:%h:%h:%h:%h/%d label".
+
 	The "::" address shortcut is not supported.
 	If label is "-DELETE" a matched entry will be deleted.
+
 load
 	Provided for backward compatibility. The load2 interface
 	is preferred and should be used instead.
 	This interface allows access control rules in addition to
 	the system defined rules to be specified. The format accepted
-	on write is:
+	on write is::
+
 		"%24s%24s%5s"
+
 	where the first string is the subject label, the second the
 	object label, and the third the requested access. The access
 	string may contain only the characters "rwxat-", and specifies
@@ -189,17 +227,21 @@ load
 	permissions that are not allowed. The string "r-x--" would
 	specify read and execute access. Labels are limited to 23
 	characters in length.
+
 load2
 	This interface allows access control rules in addition to
 	the system defined rules to be specified. The format accepted
-	on write is:
+	on write is::
+
 		"%s %s %s"
+
 	where the first string is the subject label, the second the
 	object label, and the third the requested access. The access
 	string may contain only the characters "rwxat-", and specifies
 	which sort of access is allowed. The "-" is a placeholder for
 	permissions that are not allowed. The string "r-x--" would
 	specify read and execute access.
+
 load-self
 	Provided for backward compatibility. The load-self2 interface
 	is preferred and should be used instead.
@@ -208,66 +250,83 @@ load-self
 	otherwise be permitted, and are intended to provide additional
 	restrictions on the process. The format is the same as for
 	the load interface.
+
 load-self2
 	This interface allows process specific access rules to be
 	defined. These rules are only consulted if access would
 	otherwise be permitted, and are intended to provide additional
 	restrictions on the process. The format is the same as for
 	the load2 interface.
+
 logging
 	This contains the Smack logging state.
+
 mapped
 	This contains the CIPSO level used for Smack mapped label
 	representation in network packets.
+
 netlabel
 	This interface allows specific internet addresses to be
 	treated as single label hosts. Packets are sent to single
 	label hosts without CIPSO headers, but only from processes
 	that have Smack write access to the host label. All packets
 	received from single label hosts are given the specified
-	label. The format accepted on write is:
+	label. The format accepted on write is::
+
 		"%d.%d.%d.%d label" or "%d.%d.%d.%d/%d label".
+
 	If the label specified is "-CIPSO" the address is treated
 	as a host that supports CIPSO headers.
+
 onlycap
 	This contains labels processes must have for CAP_MAC_ADMIN
-	and CAP_MAC_OVERRIDE to be effective. If this file is empty
+	and ``CAP_MAC_OVERRIDE`` to be effective. If this file is empty
 	these capabilities are effective at for processes with any
 	label. The values are set by writing the desired labels, separated
 	by spaces, to the file or cleared by writing "-" to the file.
+
 ptrace
 	This is used to define the current ptrace policy
-	0 - default: this is the policy that relies on Smack access rules.
-	    For the PTRACE_READ a subject needs to have a read access on
-	    object. For the PTRACE_ATTACH a read-write access is required.
-	1 - exact: this is the policy that limits PTRACE_ATTACH. Attach is
+
+	0 - default:
+	    this is the policy that relies on Smack access rules.
+	    For the ``PTRACE_READ`` a subject needs to have a read access on
+	    object. For the ``PTRACE_ATTACH`` a read-write access is required.
+
+	1 - exact:
+	    this is the policy that limits ``PTRACE_ATTACH``. Attach is
 	    only allowed when subject's and object's labels are equal.
-	    PTRACE_READ is not affected. Can be overridden with CAP_SYS_PTRACE.
-	2 - draconian: this policy behaves like the 'exact' above with an
-	    exception that it can't be overridden with CAP_SYS_PTRACE.
+	    ``PTRACE_READ`` is not affected. Can be overridden with ``CAP_SYS_PTRACE``.
+
+	2 - draconian:
+	    this policy behaves like the 'exact' above with an
+	    exception that it can't be overridden with ``CAP_SYS_PTRACE``.
+
 revoke-subject
 	Writing a Smack label here sets the access to '-' for all access
 	rules with that subject label.
+
 unconfined
-	If the kernel is configured with CONFIG_SECURITY_SMACK_BRINGUP
-	a process with CAP_MAC_ADMIN can write a label into this interface.
+	If the kernel is configured with ``CONFIG_SECURITY_SMACK_BRINGUP``
+	a process with ``CAP_MAC_ADMIN`` can write a label into this interface.
 	Thereafter, accesses that involve that label will be logged and
 	the access permitted if it wouldn't be otherwise. Note that this
 	is dangerous and can ruin the proper labeling of your system.
 	It should never be used in production.
+
 relabel-self
 	This interface contains a list of labels to which the process can
-	transition to, by writing to /proc/self/attr/current.
+	transition to, by writing to ``/proc/self/attr/current``.
 	Normally a process can change its own label to any legal value, but only
-	if it has CAP_MAC_ADMIN. This interface allows a process without
-	CAP_MAC_ADMIN to relabel itself to one of labels from predefined list.
-	A process without CAP_MAC_ADMIN can change its label only once. When it
+	if it has ``CAP_MAC_ADMIN``. This interface allows a process without
+	``CAP_MAC_ADMIN`` to relabel itself to one of labels from predefined list.
+	A process without ``CAP_MAC_ADMIN`` can change its label only once. When it
 	does, this list will be cleared.
 	The values are set by writing the desired labels, separated
 	by spaces, to the file or cleared by writing "-" to the file.
 
 If you are using the smackload utility
-you can add access rules in /etc/smack/accesses. They take the form:
+you can add access rules in ``/etc/smack/accesses``. They take the form::
 
     subjectlabel objectlabel access
 
@@ -277,14 +336,14 @@ object with objectlabel. If there is no rule no access is allowed.
 
 Look for additional programs on http://schaufler-ca.com
 
-From the Smack Whitepaper:
-
-The Simplified Mandatory Access Control Kernel
+The Simplified Mandatory Access Control Kernel (Whitepaper)
+===========================================================
 
 Casey Schaufler
 casey at schaufler-ca.com
 
 Mandatory Access Control
+------------------------
 
 Computer systems employ a variety of schemes to constrain how information is
 shared among the people and services using the machine. Some of these schemes
@@ -297,6 +356,7 @@ access control mechanisms because you don't have a choice regarding the users
 or programs that have access to pieces of data.
 
 Bell & LaPadula
+---------------
 
 From the middle of the 1980's until the turn of the century Mandatory Access
 Control (MAC) was very closely associated with the Bell & LaPadula security
@@ -306,6 +366,7 @@ within the Capital Beltway and Scandinavian supercomputer centers but was
 often sited as failing to address general needs.
 
 Domain Type Enforcement
+-----------------------
 
 Around the turn of the century Domain Type Enforcement (DTE) became popular.
 This scheme organizes users, programs, and data into domains that are
@@ -316,6 +377,7 @@ necessary to provide a secure domain mapping leads to the scheme being
 disabled or used in limited ways in the majority of cases.
 
 Smack
+-----
 
 Smack is a Mandatory Access Control mechanism designed to provide useful MAC
 while avoiding the pitfalls of its predecessors. The limitations of Bell &
@@ -326,46 +388,55 @@ Enforcement and avoided by defining access controls in terms of the access
 modes already in use.
 
 Smack Terminology
+-----------------
 
 The jargon used to talk about Smack will be familiar to those who have dealt
 with other MAC systems and shouldn't be too difficult for the uninitiated to
 pick up. There are four terms that are used in a specific way and that are
 especially important:
 
-	Subject: A subject is an active entity on the computer system.
+  Subject:
+	A subject is an active entity on the computer system.
 	On Smack a subject is a task, which is in turn the basic unit
 	of execution.
 
-	Object: An object is a passive entity on the computer system.
+  Object:
+	An object is a passive entity on the computer system.
 	On Smack files of all types, IPC, and tasks can be objects.
 
-	Access: Any attempt by a subject to put information into or get
+  Access:
+	Any attempt by a subject to put information into or get
 	information from an object is an access.
 
-	Label: Data that identifies the Mandatory Access Control
+  Label:
+	Data that identifies the Mandatory Access Control
 	characteristics of a subject or an object.
 
 These definitions are consistent with the traditional use in the security
 community. There are also some terms from Linux that are likely to crop up:
 
-	Capability: A task that possesses a capability has permission to
+  Capability:
+	A task that possesses a capability has permission to
 	violate an aspect of the system security policy, as identified by
 	the specific capability. A task that possesses one or more
 	capabilities is a privileged task, whereas a task with no
 	capabilities is an unprivileged task.
 
-	Privilege: A task that is allowed to violate the system security
+  Privilege:
+	A task that is allowed to violate the system security
 	policy is said to have privilege. As of this writing a task can
 	have privilege either by possessing capabilities or by having an
 	effective user of root.
 
 Smack Basics
+------------
 
 Smack is an extension to a Linux system. It enforces additional restrictions
 on what subjects can access which objects, based on the labels attached to
 each of the subject and the object.
 
 Labels
+~~~~~~
 
 Smack labels are ASCII character strings. They can be up to 255 characters
 long, but keeping them to twenty-three characters is recommended.
@@ -377,7 +448,7 @@ contain unprintable characters, the "/" (slash), the "\" (backslash), the "'"
 (quote) and '"' (double-quote) characters.
 Smack labels cannot begin with a '-'. This is reserved for special options.
 
-There are some predefined labels:
+There are some predefined labels::
 
 	_ 	Pronounced "floor", a single underscore character.
 	^ 	Pronounced "hat", a single circumflex character.
@@ -390,14 +461,18 @@ of a process will usually be assigned by the system initialization
 mechanism.
 
 Access Rules
+~~~~~~~~~~~~
 
 Smack uses the traditional access modes of Linux. These modes are read,
 execute, write, and occasionally append. There are a few cases where the
 access mode may not be obvious. These include:
 
-	Signals: A signal is a write operation from the subject task to
+  Signals:
+	A signal is a write operation from the subject task to
 	the object task.
-	Internet Domain IPC: Transmission of a packet is considered a
+
+  Internet Domain IPC:
+	Transmission of a packet is considered a
 	write operation from the source task to the destination task.
 
 Smack restricts access based on the label attached to a subject and the label
@@ -417,6 +492,7 @@ order:
 	7. Any other access is denied.
 
 Smack Access Rules
+~~~~~~~~~~~~~~~~~~
 
 With the isolation provided by Smack access separation is simple. There are
 many interesting cases where limited access by subjects to objects with
@@ -427,8 +503,9 @@ be "born" highly classified. To accommodate such schemes Smack includes a
 mechanism for specifying rules allowing access between labels.
 
 Access Rule Format
+~~~~~~~~~~~~~~~~~~
 
-The format of an access rule is:
+The format of an access rule is::
 
 	subject-label object-label access
 
@@ -446,7 +523,7 @@ describe access modes:
 
 Uppercase values for the specification letters are allowed as well.
 Access mode specifications can be in any order. Examples of acceptable rules
-are:
+are::
 
 	TopSecret Secret  rx
 	Secret    Unclass R
@@ -456,7 +533,7 @@ are:
 	New       Old     rRrRr
 	Closed    Off     -
 
-Examples of unacceptable rules are:
+Examples of unacceptable rules are::
 
 	Top Secret Secret     rx
 	Ace        Ace        r
@@ -469,6 +546,7 @@ access specifications. The dash is a placeholder, so "a-r" is the same
 as "ar". A lone dash is used to specify that no access should be allowed.
 
 Applying Access Rules
+~~~~~~~~~~~~~~~~~~~~~
 
 The developers of Linux rarely define new sorts of things, usually importing
 schemes and concepts from other systems. Most often, the other systems are
@@ -511,6 +589,7 @@ one process to another requires that the sender have write access to the
 receiver. The receiver is not required to have read access to the sender.
 
 Setting Access Rules
+~~~~~~~~~~~~~~~~~~~~
 
 The configuration file /etc/smack/accesses contains the rules to be set at
 system startup. The contents are written to the special file
@@ -520,6 +599,7 @@ one rule, with the most recently specified overriding any earlier
 specification.
 
 Task Attribute
+~~~~~~~~~~~~~~
 
 The Smack label of a process can be read from /proc/<pid>/attr/current. A
 process can read its own Smack label from /proc/self/attr/current. A
@@ -527,12 +607,14 @@ privileged process can change its own Smack label by writing to
 /proc/self/attr/current but not the label of another process.
 
 File Attribute
+~~~~~~~~~~~~~~
 
 The Smack label of a filesystem object is stored as an extended attribute
 named SMACK64 on the file. This attribute is in the security namespace. It can
 only be changed by a process with privilege.
 
 Privilege
+~~~~~~~~~
 
 A process with CAP_MAC_OVERRIDE or CAP_MAC_ADMIN is privileged.
 CAP_MAC_OVERRIDE allows the process access to objects it would
@@ -540,6 +622,7 @@ be denied otherwise. CAP_MAC_ADMIN allows a process to change
 Smack data, including rules and attributes.
 
 Smack Networking
+~~~~~~~~~~~~~~~~
 
 As mentioned before, Smack enforces access control on network protocol
 transmissions. Every packet sent by a Smack process is tagged with its Smack
@@ -551,6 +634,7 @@ packet has write access to the receiving process and if that is not the case
 the packet is dropped.
 
 CIPSO Configuration
+~~~~~~~~~~~~~~~~~~~
 
 It is normally unnecessary to specify the CIPSO configuration. The default
 values used by the system handle all internal cases. Smack will compose CIPSO
@@ -571,13 +655,13 @@ discarded. The DOI is 3 by default. The value can be read from
 The label and category set are mapped to a Smack label as defined in
 /etc/smack/cipso.
 
-A Smack/CIPSO mapping has the form:
+A Smack/CIPSO mapping has the form::
 
 	smack level [category [category]*]
 
 Smack does not expect the level or category sets to be related in any
 particular way and does not assume or assign accesses based on them. Some
-examples of mappings:
+examples of mappings::
 
 	TopSecret 7
 	TS:A,B    7 1 2
@@ -597,25 +681,30 @@ value can be read from /sys/fs/smackfs/direct and changed by writing to
 /sys/fs/smackfs/direct.
 
 Socket Attributes
+~~~~~~~~~~~~~~~~~
 
 There are two attributes that are associated with sockets. These attributes
 can only be set by privileged tasks, but any task can read them for their own
 sockets.
 
-	SMACK64IPIN: The Smack label of the task object. A privileged
+  SMACK64IPIN:
+	The Smack label of the task object. A privileged
 	program that will enforce policy may set this to the star label.
 
-	SMACK64IPOUT: The Smack label transmitted with outgoing packets.
+  SMACK64IPOUT:
+	The Smack label transmitted with outgoing packets.
 	A privileged program may set this to match the label of another
 	task with which it hopes to communicate.
 
 Smack Netlabel Exceptions
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You will often find that your labeled application has to talk to the outside,
 unlabeled world. To do this there's a special file /sys/fs/smackfs/netlabel
-where you can add some exceptions in the form of :
- at IP1	   LABEL1 or
- at IP2/MASK  LABEL2
+where you can add some exceptions in the form of::
+
+	@IP1	   LABEL1 or
+	@IP2/MASK  LABEL2
 
 It means that your application will have unlabeled access to @IP1 if it has
 write access on LABEL1, and access to the subnet @IP2/MASK if it has write
@@ -624,28 +713,32 @@ access on LABEL2.
 Entries in the /sys/fs/smackfs/netlabel file are matched by longest mask
 first, like in classless IPv4 routing.
 
-A special label '@' and an option '-CIPSO' can be used there :
-@      means Internet, any application with any label has access to it
--CIPSO means standard CIPSO networking
+A special label '@' and an option '-CIPSO' can be used there::
 
-If you don't know what CIPSO is and don't plan to use it, you can just do :
-echo 127.0.0.1 -CIPSO > /sys/fs/smackfs/netlabel
-echo 0.0.0.0/0 @      > /sys/fs/smackfs/netlabel
+	@      means Internet, any application with any label has access to it
+	-CIPSO means standard CIPSO networking
+
+If you don't know what CIPSO is and don't plan to use it, you can just do::
+
+	echo 127.0.0.1 -CIPSO > /sys/fs/smackfs/netlabel
+	echo 0.0.0.0/0 @      > /sys/fs/smackfs/netlabel
 
 If you use CIPSO on your 192.168.0.0/16 local network and need also unlabeled
-Internet access, you can have :
-echo 127.0.0.1      -CIPSO > /sys/fs/smackfs/netlabel
-echo 192.168.0.0/16 -CIPSO > /sys/fs/smackfs/netlabel
-echo 0.0.0.0/0      @      > /sys/fs/smackfs/netlabel
+Internet access, you can have::
 
+	echo 127.0.0.1      -CIPSO > /sys/fs/smackfs/netlabel
+	echo 192.168.0.0/16 -CIPSO > /sys/fs/smackfs/netlabel
+	echo 0.0.0.0/0      @      > /sys/fs/smackfs/netlabel
 
 Writing Applications for Smack
+------------------------------
 
 There are three sorts of applications that will run on a Smack system. How an
 application interacts with Smack will determine what it will have to do to
 work properly under Smack.
 
 Smack Ignorant Applications
+---------------------------
 
 By far the majority of applications have no reason whatever to care about the
 unique properties of Smack. Since invoking a program has no impact on the
@@ -653,12 +746,14 @@ Smack label associated with the process the only concern likely to arise is
 whether the process has execute access to the program.
 
 Smack Relevant Applications
+---------------------------
 
 Some programs can be improved by teaching them about Smack, but do not make
 any security decisions themselves. The utility ls(1) is one example of such a
 program.
 
 Smack Enforcing Applications
+----------------------------
 
 These are special programs that not only know about Smack, but participate in
 the enforcement of system policy. In most cases these are the programs that
@@ -666,15 +761,16 @@ set up user sessions. There are also network services that provide information
 to processes running with various labels.
 
 File System Interfaces
+----------------------
 
 Smack maintains labels on file system objects using extended attributes. The
 Smack label of a file, directory, or other file system object can be obtained
-using getxattr(2).
+using getxattr(2)::
 
 	len = getxattr("/", "security.SMACK64", value, sizeof (value));
 
 will put the Smack label of the root directory into value. A privileged
-process can set the Smack label of a file system object with setxattr(2).
+process can set the Smack label of a file system object with setxattr(2)::
 
 	len = strlen("Rubble");
 	rc = setxattr("/foo", "security.SMACK64", "Rubble", len, 0);
@@ -683,17 +779,18 @@ will set the Smack label of /foo to "Rubble" if the program has appropriate
 privilege.
 
 Socket Interfaces
+-----------------
 
 The socket attributes can be read using fgetxattr(2).
 
 A privileged process can set the Smack label of outgoing packets with
-fsetxattr(2).
+fsetxattr(2)::
 
 	len = strlen("Rubble");
 	rc = fsetxattr(fd, "security.SMACK64IPOUT", "Rubble", len, 0);
 
 will set the Smack label "Rubble" on packets going out from the socket if the
-program has appropriate privilege.
+program has appropriate privilege::
 
 	rc = fsetxattr(fd, "security.SMACK64IPIN, "*", strlen("*"), 0);
 
@@ -701,33 +798,40 @@ will set the Smack label "*" as the object label against which incoming
 packets will be checked if the program has appropriate privilege.
 
 Administration
+--------------
 
 Smack supports some mount options:
 
-	smackfsdef=label: specifies the label to give files that lack
+  smackfsdef=label:
+	specifies the label to give files that lack
 	the Smack label extended attribute.
 
-	smackfsroot=label: specifies the label to assign the root of the
+  smackfsroot=label:
+	specifies the label to assign the root of the
 	file system if it lacks the Smack extended attribute.
 
-	smackfshat=label: specifies a label that must have read access to
+  smackfshat=label:
+	specifies a label that must have read access to
 	all labels set on the filesystem. Not yet enforced.
 
-	smackfsfloor=label: specifies a label to which all labels set on the
+  smackfsfloor=label:
+	specifies a label to which all labels set on the
 	filesystem must have read access. Not yet enforced.
 
 These mount options apply to all file system types.
 
 Smack auditing
+--------------
 
 If you want Smack auditing of security events, you need to set CONFIG_AUDIT
 in your kernel configuration.
 By default, all denied events will be audited. You can change this behavior by
-writing a single character to the /sys/fs/smackfs/logging file :
-0 : no logging
-1 : log denied (default)
-2 : log accepted
-3 : log denied & accepted
+writing a single character to the /sys/fs/smackfs/logging file::
+
+	0 : no logging
+	1 : log denied (default)
+	2 : log accepted
+	3 : log denied & accepted
 
 Events are logged as 'key=value' pairs, for each event you at least will get
 the subject, the object, the rights requested, the action, the kernel function
@@ -735,6 +839,7 @@ that triggered the event, plus other pairs depending on the type of event
 audited.
 
 Bringup Mode
+------------
 
 Bringup mode provides logging features that can make application
 configuration and system bringup easier. Configure the kernel with
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index 41f5262359f9..c980dfe9abf1 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -36,5 +36,6 @@ the one "major" module (e.g. SELinux) if there is one configured.
    apparmor
    LoadPin
    SELinux
+   Smack
    tomoyo
    Yama
diff --git a/Documentation/security/00-INDEX b/Documentation/security/00-INDEX
index a55f781be0dd..cdb2294ec047 100644
--- a/Documentation/security/00-INDEX
+++ b/Documentation/security/00-INDEX
@@ -1,7 +1,5 @@
 00-INDEX
 	- this file.
-Smack.txt
-	- documentation on the Smack Linux Security Module.
 keys-ecryptfs.txt
 	- description of the encryption keys for the ecryptfs filesystem.
 keys-request-key.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c1560c75aa6..3e78b5c9b3f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11876,7 +11876,7 @@ L:	linux-security-module at vger.kernel.org
 W:	http://schaufler-ca.com
 T:	git git://github.com/cschaufler/smack-next
 S:	Maintained
-F:	Documentation/security/Smack.txt
+F:	Documentation/admin-guide/LSM/Smack.rst
 F:	security/smack/
 
 DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
