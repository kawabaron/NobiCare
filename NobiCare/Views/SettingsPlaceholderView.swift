import SwiftUI

struct SettingsPlaceholderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("設定")
                .font(NCTypography.h2)
                .foregroundColor(NCColors.nightText)
            Text("通知・音・表示設定は本番版で調整予定です。今はナイトモードの雰囲気と操作感を確認できます。")
                .font(NCTypography.caption)
                .foregroundColor(NCColors.nightText.opacity(0.66))
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(NCColors.nightCard.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(NCColors.sage.opacity(0.15), lineWidth: 1))
    }
}
