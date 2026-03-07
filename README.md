[Untitled Diagram2.drawio](https://github.com/user-attachments/files/25820009/Untitled.Diagram2.drawio)## ECS Outline inspired project

- Dockerised app (multi-stage build), pushed images to **ECR**
- Deployed on **ECS Fargate** behind an **ALB** (HTTP/HTTPS) with `/health` checks
- Cloudfront as first point of entry for reduced latency.
- Private **S3 uploads** via **pre-signed URLs**
- **Integrated RDS (Postgres)** for persisted metadata (uploads/invites + future docs)
- **ACM TLS** + **Cloudflare DNS** (DNS validation)
- **Terraform modules** + remote **S3 state backend** with state locking enabled
- **GitHub Actions OIDC** for deploys — **no static AWS keys**

## Architecture Diagram
[Uploading U<mxfile host="app.diagrams.net" agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36" version="29.6.1">
  <diagram name="Page-1" id="BadnWNlcNr56SQDEb0hS">
    <mxGraphModel dx="1303" dy="778" grid="0" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" background="light-dark(#FFFFFF,#FFFFFF)" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-1" parent="1" style="sketch=0;outlineConnect=0;gradientColor=none;fontColor=#545B64;strokeColor=none;fillColor=#879196;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.illustration_users;pointerEvents=1" value="users" vertex="1">
          <mxGeometry height="39" width="39" x="359" y="70" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-5" parent="1" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_aws_cloud;strokeColor=#232F3E;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#232F3E;dashed=0;" value="AWS Cloud" vertex="1">
          <mxGeometry height="588" width="783" x="24" y="277" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-48" parent="2U3kvdAgUwKMEAs7Yf81-5" style="sketch=0;points=[[0,0,0],[0.25,0,0],[0.5,0,0],[0.75,0,0],[1,0,0],[0,1,0],[0.25,1,0],[0.5,1,0],[0.75,1,0],[1,1,0],[0,0.25,0],[0,0.5,0],[0,0.75,0],[1,0.25,0],[1,0.5,0],[1,0.75,0]];outlineConnect=0;fontColor=#232F3E;fillColor=#8C4FFF;strokeColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.cloudfront;" value="" vertex="1">
          <mxGeometry height="53.5" width="53.5" x="326" y="7.7" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-6" parent="1" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;strokeColor=#8C4FFF;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#AAB7B8;dashed=0;" value="VPC" vertex="1">
          <mxGeometry height="381" width="659" x="79" y="445" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-7" parent="2U3kvdAgUwKMEAs7Yf81-6" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=#00A4A6;fillColor=light-dark(#FFFFFF,#E6E6E6);verticalAlign=top;align=left;spacingLeft=30;fontColor=#147EBA;dashed=0;" value="Private subnet" vertex="1">
          <mxGeometry height="130" width="228" x="10" y="224" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-11" parent="2U3kvdAgUwKMEAs7Yf81-6" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=0;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=#00A4A6;fillColor=light-dark(#FFFFFF,#E6E6E6);verticalAlign=top;align=left;spacingLeft=30;fontColor=#147EBA;dashed=0;direction=east;" value="Private subnet" vertex="1">
          <mxGeometry height="125" width="221" x="315" y="229" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-12" parent="2U3kvdAgUwKMEAs7Yf81-6" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=light-dark(#7AA116,#000000);fillColor=light-dark(#F2F6E8,#E6E6E6);verticalAlign=top;align=left;spacingLeft=30;fontColor=#248814;dashed=0;" value="Public subnet" vertex="1">
          <mxGeometry height="130" width="221" x="10" y="39" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-13" parent="2U3kvdAgUwKMEAs7Yf81-6" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=light-dark(#7AA116,#000000);fillColor=light-dark(#F2F6E8,#E6E6E6);verticalAlign=top;align=left;spacingLeft=30;fontColor=#248814;dashed=0;" value="Public subnet" vertex="1">
          <mxGeometry height="130" width="215" x="324" y="48.5" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-15" parent="2U3kvdAgUwKMEAs7Yf81-6" style="fillColor=none;strokeColor=#147EBA;dashed=1;verticalAlign=top;fontStyle=0;fontColor=#147EBA;whiteSpace=wrap;html=1;" value="Availability Zone" vertex="1">
          <mxGeometry height="345" width="245" x="309" y="20" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-21" parent="2U3kvdAgUwKMEAs7Yf81-6" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#8C4FFF;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.internet_gateway;" value="" vertex="1">
          <mxGeometry height="52" width="52" x="256" y="-25" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-26" parent="2U3kvdAgUwKMEAs7Yf81-6" style="sketch=0;points=[[0,0,0],[0.25,0,0],[0.5,0,0],[0.75,0,0],[1,0,0],[0,1,0],[0.25,1,0],[0.5,1,0],[0.75,1,0],[1,1,0],[0,0.25,0],[0,0.5,0],[0,0.75,0],[1,0.25,0],[1,0.5,0],[1,0.75,0]];outlineConnect=0;fontColor=#232F3E;fillColor=#C925D1;strokeColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.rds;" value="" vertex="1">
          <mxGeometry height="36" width="36" x="28" y="299" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-27" parent="2U3kvdAgUwKMEAs7Yf81-6" style="sketch=0;points=[[0,0,0],[0.25,0,0],[0.5,0,0],[0.75,0,0],[1,0,0],[0,1,0],[0.25,1,0],[0.5,1,0],[0.75,1,0],[1,1,0],[0,0.25,0],[0,0.5,0],[0,0.75,0],[1,0.25,0],[1,0.5,0],[1,0.75,0]];outlineConnect=0;fontColor=#232F3E;fillColor=#C925D1;strokeColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.rds;" value="" vertex="1">
          <mxGeometry height="40" width="40" x="481" y="303" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-29" parent="2U3kvdAgUwKMEAs7Yf81-6" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#C925D1;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.elasticache_for_redis;" value="" vertex="1">
          <mxGeometry height="38.04" width="43" x="24" y="255.42" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-25" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-20" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-21" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="375" y="515" as="sourcePoint" />
            <mxPoint x="484" y="604" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-32" parent="1" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_region;strokeColor=#00A4A6;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#147EBA;dashed=1;" value="Region" vertex="1">
          <mxGeometry height="498" width="739" x="50" y="344" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-33" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;points=[[0,0,0],[0.25,0,0],[0.5,0,0],[0.75,0,0],[1,0,0],[0,1,0],[0.25,1,0],[0.5,1,0],[0.75,1,0],[1,1,0],[0,0.25,0],[0,0.5,0],[0,0.75,0],[1,0.25,0],[1,0.5,0],[1,0.75,0]];outlineConnect=0;fontColor=#232F3E;fillColor=#DD344C;strokeColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.certificate_manager_3;" value="" vertex="1">
          <mxGeometry height="56" width="56" x="495" y="25" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-34" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#ffffff;fillColor=#232F3E;dashed=0;verticalLabelPosition=middle;verticalAlign=bottom;align=center;html=1;whiteSpace=wrap;fontSize=10;fontStyle=1;spacing=3;shape=mxgraph.aws4.productIcon;prIcon=mxgraph.aws4.ecr;" value="Amazon ECR" vertex="1">
          <mxGeometry height="75" width="42" x="432" y="15.5" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-16" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;points=[[0,0,0],[0.25,0,0],[0.5,0,0],[0.75,0,0],[1,0,0],[0,1,0],[0.25,1,0],[0.5,1,0],[0.75,1,0],[1,1,0],[0,0.25,0],[0,0.5,0],[0,0.75,0],[1,0.25,0],[1,0.5,0],[1,0.75,0]];outlineConnect=0;fontColor=#232F3E;fillColor=#ED7100;strokeColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.ecs;" value="" vertex="1">
          <mxGeometry height="39" width="39" x="191" y="373" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-17" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;points=[[0,0,0],[0.25,0,0],[0.5,0,0],[0.75,0,0],[1,0,0],[0,1,0],[0.25,1,0],[0.5,1,0],[0.75,1,0],[1,1,0],[0,0.25,0],[0,0.5,0],[0,0.75,0],[1,0.25,0],[1,0.5,0],[1,0.75,0]];outlineConnect=0;fontColor=#232F3E;fillColor=#ED7100;strokeColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.ecs;" value="" vertex="1">
          <mxGeometry height="38" width="38" x="373" y="380" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-19" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#8C4FFF;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.nat_gateway;" value="" vertex="1">
          <mxGeometry height="42.5" width="42.5" x="379" y="193.25" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-31" edge="1" parent="2U3kvdAgUwKMEAs7Yf81-32" source="2U3kvdAgUwKMEAs7Yf81-17" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);exitX=0.5;exitY=0;exitDx=0;exitDy=0;exitPerimeter=0;" target="2U3kvdAgUwKMEAs7Yf81-19" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="475" y="382" as="sourcePoint" />
            <mxPoint x="604" y="375" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-18" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#8C4FFF;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.nat_gateway;" value="" vertex="1">
          <mxGeometry height="45" width="45" x="213" y="192" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-30" edge="1" parent="2U3kvdAgUwKMEAs7Yf81-32" source="2U3kvdAgUwKMEAs7Yf81-16" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);exitX=0.5;exitY=0;exitDx=0;exitDy=0;exitPerimeter=0;" target="2U3kvdAgUwKMEAs7Yf81-18" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="155" y="370" as="sourcePoint" />
            <mxPoint x="147.83861000000002" y="215.89499999999998" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-41" parent="2U3kvdAgUwKMEAs7Yf81-32" style="fillColor=none;strokeColor=#147EBA;dashed=1;verticalAlign=top;fontStyle=0;fontColor=#147EBA;whiteSpace=wrap;html=1;" value="Availability Zone" vertex="1">
          <mxGeometry height="348" width="245" x="32" y="119" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-20" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#8C4FFF;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.application_load_balancer;" value="" vertex="1">
          <mxGeometry height="52" width="52" x="285" y="196" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-61" edge="1" parent="2U3kvdAgUwKMEAs7Yf81-32" source="2U3kvdAgUwKMEAs7Yf81-20" style="endArrow=classic;html=1;rounded=0;entryX=0.792;entryY=0.753;entryDx=0;entryDy=0;entryPerimeter=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-41" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="296" y="199" as="sourcePoint" />
            <mxPoint x="346" y="149" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-62" edge="1" parent="2U3kvdAgUwKMEAs7Yf81-32" source="2U3kvdAgUwKMEAs7Yf81-20" style="endArrow=classic;html=1;rounded=0;entryX=0;entryY=0.25;entryDx=0;entryDy=0;entryPerimeter=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-17" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="394" y="254" as="sourcePoint" />
            <mxPoint x="323" y="387" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-28" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#C925D1;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.elasticache_for_redis;" value="" vertex="1">
          <mxGeometry height="42.46" width="48" x="506" y="340" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-35" edge="1" parent="2U3kvdAgUwKMEAs7Yf81-32" source="2U3kvdAgUwKMEAs7Yf81-17" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);exitX=1;exitY=0;exitDx=0;exitDy=0;exitPerimeter=0;" target="2U3kvdAgUwKMEAs7Yf81-28" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="494" y="380" as="sourcePoint" />
            <mxPoint x="384" y="220" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-40" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=light-dark(#000000,#000000);gradientColor=none;fillColor=#7AA116;strokeColor=none;dashed=0;verticalLabelPosition=top;verticalAlign=bottom;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.bucket;labelPosition=center;direction=east;" value="File/Uploads" vertex="1">
          <mxGeometry height="57.2" width="55" x="580" y="21.00000000000001" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-65" parent="2U3kvdAgUwKMEAs7Yf81-32" style="sketch=0;outlineConnect=0;fontColor=light-dark(#000000,#000000);gradientColor=none;fillColor=#7AA116;strokeColor=none;dashed=0;verticalLabelPosition=top;verticalAlign=bottom;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.bucket;labelPosition=center;direction=east;" value="Terraform state" vertex="1">
          <mxGeometry height="57.2" width="55" x="661" y="21" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-64" edge="1" parent="2U3kvdAgUwKMEAs7Yf81-32" source="2U3kvdAgUwKMEAs7Yf81-17" style="endArrow=classic;html=1;rounded=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;exitPerimeter=0;fontColor=light-dark(#000000,#000000);strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-40" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <Array as="points">
              <mxPoint x="614" y="383" />
            </Array>
            <mxPoint x="212" y="131" as="sourcePoint" />
            <mxPoint x="610" y="112" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-23" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-18" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-21" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="210.38392999999996" y="540.344" as="sourcePoint" />
            <mxPoint x="434" y="538" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-36" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-17" style="endArrow=classic;html=1;rounded=0;exitX=1;exitY=1;exitDx=0;exitDy=0;exitPerimeter=0;strokeColor=light-dark(#000000,#000000);" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="556" y="787" as="sourcePoint" />
            <mxPoint x="558" y="770" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-38" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-16" style="endArrow=classic;html=1;rounded=0;entryX=1;entryY=0.75;entryDx=0;entryDy=0;entryPerimeter=0;strokeColor=light-dark(#000000,#000000);exitX=0;exitY=1;exitDx=0;exitDy=0;exitPerimeter=0;" target="2U3kvdAgUwKMEAs7Yf81-26" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="188" y="752" as="sourcePoint" />
            <mxPoint x="434" y="564" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-39" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-16" style="endArrow=classic;html=1;rounded=0;exitX=0;exitY=0;exitDx=0;exitDy=0;exitPerimeter=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-29" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="384" y="614" as="sourcePoint" />
            <mxPoint x="434" y="564" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-24" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-19" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-21" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="494" y="609" as="sourcePoint" />
            <mxPoint x="616" y="536" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-42" parent="1" style="image;sketch=0;aspect=fixed;html=1;points=[];align=center;fontSize=12;image=img/lib/mscae/Docker.svg;" value="" vertex="1">
          <mxGeometry height="41" width="50" x="477" y="161" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-43" parent="1" style="dashed=0;outlineConnect=0;html=1;align=center;labelPosition=center;verticalLabelPosition=bottom;verticalAlign=top;shape=mxgraph.weblogos.github" value="&lt;font style=&quot;color: light-dark(rgb(0, 0, 0), rgb(0, 0, 0));&quot;&gt;Github actions&lt;/font&gt;" vertex="1">
          <mxGeometry height="46" width="51" x="577" y="159" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-44" parent="1" style="html=1;verticalLabelPosition=bottom;align=center;labelBackgroundColor=light-dark(#FFFFFF,#FFFFFF);verticalAlign=top;strokeWidth=2;strokeColor=#0080F0;shadow=0;dashed=0;shape=mxgraph.ios7.icons.user;fontColor=light-dark(#000000,#000000);fillColor=default;" value="Developer" vertex="1">
          <mxGeometry height="40" width="42" x="700" y="161" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-45" edge="1" parent="1" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-43" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="693" y="182" as="sourcePoint" />
            <mxPoint x="434" y="267" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-46" edge="1" parent="1" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);entryX=0.964;entryY=0.424;entryDx=0;entryDy=0;entryPerimeter=0;" target="2U3kvdAgUwKMEAs7Yf81-42" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="579" y="178" as="sourcePoint" />
            <mxPoint x="545" y="175" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-47" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-42" style="endArrow=classic;html=1;rounded=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-34" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="540" y="228" as="sourcePoint" />
            <mxPoint x="475" y="228" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-53" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-20" style="edgeStyle=orthogonalEdgeStyle;html=1;endArrow=none;elbow=vertical;startArrow=openThin;startFill=0;strokeColor=light-dark(#545B64,#000000);rounded=0;exitX=0.958;exitY=0.565;exitDx=0;exitDy=0;exitPerimeter=0;fontColor=light-dark(#000000,#000000);" value="">
          <mxGeometry relative="1" width="100" as="geometry">
            <Array as="points">
              <mxPoint x="385" y="563" />
              <mxPoint x="414" y="563" />
              <mxPoint x="414" y="312" />
            </Array>
            <mxPoint x="306" y="384" as="sourcePoint" />
            <mxPoint x="404" y="312" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-55" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-54" style="endArrow=classic;html=1;rounded=0;entryX=0.5;entryY=0;entryDx=0;entryDy=0;entryPerimeter=0;exitX=0.5;exitY=1;exitDx=0;exitDy=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-48" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <mxPoint x="342" y="397" as="sourcePoint" />
            <mxPoint x="392" y="347" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-56" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-54" style="endArrow=classic;html=1;rounded=0;exitX=0.5;exitY=1;exitDx=0;exitDy=0;strokeColor=light-dark(#000000,#000000);" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <Array as="points">
              <mxPoint x="379" y="126" />
            </Array>
            <mxPoint x="379" y="184" as="sourcePoint" />
            <mxPoint x="379" y="180" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-58" edge="1" parent="1" style="endArrow=classic;html=1;rounded=0;exitX=0.5;exitY=1;exitDx=0;exitDy=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-54" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <Array as="points" />
            <mxPoint x="379" y="184" as="sourcePoint" />
            <mxPoint x="379" y="180" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-54" parent="1" style="image;aspect=fixed;perimeter=ellipsePerimeter;html=1;align=right;shadow=0;dashed=0;spacingTop=3;image=img/lib/active_directory/internet_cloud.svg;labelBackgroundColor=none;fontColor=light-dark(#000000,#000000);labelPosition=left;verticalLabelPosition=middle;verticalAlign=middle;textDirection=ltr;" value="Internet - https://nur-trade.org" vertex="1">
          <mxGeometry height="31.5" width="50" x="352" y="182" as="geometry" />
        </mxCell>
        <mxCell id="2U3kvdAgUwKMEAs7Yf81-59" edge="1" parent="1" source="2U3kvdAgUwKMEAs7Yf81-21" style="endArrow=classic;html=1;rounded=0;entryX=0;entryY=1;entryDx=0;entryDy=0;strokeColor=light-dark(#000000,#000000);" target="2U3kvdAgUwKMEAs7Yf81-54" value="">
          <mxGeometry height="50" relative="1" width="50" as="geometry">
            <Array as="points">
              <mxPoint x="288" y="318" />
            </Array>
            <mxPoint x="346" y="437" as="sourcePoint" />
            <mxPoint x="396" y="387" as="targetPoint" />
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
ntitled Diagram2.drawio…]()

- ## Repo Structure

```text
.
├── .github/
│   └── workflows/
│       ├── push.yaml           # Build & push Docker image to ECR
│       ├── tf.plan.yaml        # Terraform plan (CI)
│       ├── tf.apply.yaml       # Terraform apply (manual, OIDC)
│       └── tf.destroy.yaml     # Terraform destroy (manual cleanup)

├── Docker/
│   ├── Dockerfile              # Production container build
│   ├── docker-compose.yml      # Local dev (optional)
│   └── .dockerignore

├── Infra/
│   ├── main.tf                 # Root module wiring
│   ├── variables.tf            # Root inputs
│   ├── terraform.tfvars        # Local values (do not commit secrets)
│   ├── backend.tf              # Remote S3 state backend (state locking enabled)
│   ├── provider.tf             # Providers (AWS/Cloudflare)
│   └── modules/                # Reusable Terraform modules
│       ├── vpc/                # VPC + public/private subnets
│       ├── sg/                 # Security groups (ALB/ECS/RDS rules)
│       ├── iam/                # ECS task/execution roles + policies (S3/Secrets)
│       ├── ecr/                # ECR repository
│       ├── alb/                # ALB + target group + listeners (80/443)
│       ├── ecs/                # ECS cluster/service/task definition (Fargate)
│       ├── s3/                 # Private uploads bucket
│       ├── acm/                # TLS cert (ACM) + DNS validation
│       ├── rds/                # Postgres (RDS) integration
│       └── cdn/                # Cloudfront integreation for the Caching

├── app/
│   ├── public/                 # Static UI (index + uploads pages)
│   ├── src/server.js           # App server (API + static routes)
│   ├── server.js               # Runtime entry (used by Docker)
│   └── package.json

├── .gitignore                  # Ignore tfstate, .terraform, node_modules, secrets
└── README.md
```
## CI/CD (GitHub Actions)

All workflows are run via **`workflow_dispatch`** (manual triggers) to keep deployments controlled and prevent accidental changes.

### Build & Push (Docker → ECR)
Manual trigger (`workflow_dispatch`):

- Builds the container image (multi-stage Dockerfile)
- Tags the image with the **commit SHA** for traceable releases
- Authenticates to AWS using **GitHub Actions OIDC** (no static AWS keys)
- Pushes the image to **Amazon ECR**

### Terraform Plan
Manual trigger (`workflow_dispatch`) with a confirmation input (e.g. type `PLAN`):

- Runs `terraform fmt -check` to enforce formatting
- Runs `terraform init -input=false` using the remote backend (state in S3)
- Runs `terraform validate` and `tflint` for static checks
- Runs `terraform plan` (non-interactive) to preview changes
- Injects runtime values via `TF_VAR_*` (e.g., Cloudflare token) — not stored in the repo

### Deploy (Terraform Apply)
Manual trigger (`workflow_dispatch`) (confirmation-gated):

- Runs Terraform from `./Infra` (consistent working directory)
- Runs `terraform init` → `terraform plan` → `terraform apply` (non-interactive)
- Uses **OIDC role assumption** for AWS access (no long-lived credentials)

### Terraform Destroy (Cleanup)
Manual trigger (`workflow_dispatch`) for safe teardown:

- Runs `terraform destroy` to remove Terraform-managed AWS resources
- Uses **OIDC** + confirmation gating to prevent accidental deletion
- Keeps the environment reproducible and cost-controlled

- # Build and Push to ECR
<img width="1853" height="962" alt="Screenshot 2026-01-09 150940" src="https://github.com/user-attachments/assets/58d38f9d-31a5-4b25-95ab-c7ecc95bf305" />

# Terraform Plan
<img width="1852" height="969" alt="Screenshot 2026-01-09 000732" src="https://github.com/user-attachments/assets/d47adbf9-0ebb-4d74-8576-4b657f00aaa4" />

# Terraform Apply
  
<img width="1881" height="1013" alt="Screenshot 2026-01-09 150845" src="https://github.com/user-attachments/assets/ae314ab3-1fd1-436d-8e74-04c9f2b90b74" />

# Terrafrom Destroy
  

<img width="1839" height="977" alt="Screenshot 2026-01-09 151207" src="https://github.com/user-attachments/assets/20290287-3bf0-4823-9aa6-63c175516e93" />

# Finished version of the app with my URL

<img width="1866" height="1056" alt="Screenshot 2026-03-06 135034" src="https://github.com/user-attachments/assets/d21ab65c-2e94-48a1-a98f-d6e2153d17b6" />


## Run locally - Test it yourself! (Docker Compose)

# 1) Build the Docker image (run from the repo root)
- docker build -f docker/Dockerfile -t outline-runner .

# 2) Create your local env file from the template
- cp .env.example .env

# 3) Generate required secrets (run both commands)
- openssl rand -hex 32
- openssl rand -hex 32

# 4) Paste the two outputs into your .env file as:
- SECRET_KEY=<first_output>
- UTILS_SECRET=<second_output>

# 5) Start Postgres + Redis + Outline
- docker compose -f docker-compose.local.yml up -d

# 6) Health check (should return 200 OK and "OK")
- curl -i http://localhost:8080/_health

# 7) To open the website
- http://localhost:8080

# 8) To stop everything
- docker compose -f docker-compose.local.yml down


# Improvments for the future
- When I am modularising my work, have all the security groups for the ALB, RDS etc all in the Security group module and not seperated, half in one and half in another module.
- Track usage, and scale for load.
- Add a bash script that will generate the secrets for the users testing this locally which wiil save time. Instead of typing in the commands to create the secrets.
- Use a VPC Endpoint instead of a NAT Gateway to reduce costs.
- Separate environments (dev/stage/prod) with Terraform workspaces or env folders.
- Blue/Green or Canary deployments instead of pushing to production.
